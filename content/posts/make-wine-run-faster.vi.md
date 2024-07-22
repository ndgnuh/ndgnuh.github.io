---
title: "Giảm độ trễ của Wine"
date: 2024-07-22T11:06:34+07:00
categories:
tags:
- foss
- wine
- linux
keywords:
- foss
- wine
- windows
- linux
summary: "Cách giảm thời gian khởi động của các ứng dụng chạy với Wine từ trên 10 giây xuống còn dưới 1 giây. TL;DR: Giấu font chữ của hệ thống khỏi Wine."
---

## Giới thiệu

Wine là một *lớp tương thích*, giúp chạy các phần mềm Windows ở trên Linux.
Sau nhiều năm được phát triển, Wine hoạt động khá tốt với nhiều phần mềm trên Windows (ví dụ như [Office](https://appdb.winehq.org/objectManager.php?sClass=application&iId=10), Zalo, và kha khá [game](https://www.protondb.com/)).

Tuy nhiên, Wine có một vấn đề tương đối gây khó chịu, đó là Wine khởi động rất chậm trên một số máy tính. Đôi lúc Wine tốn 10-20s chỉ để mở `notepad` hoặc `winecfg`. Bài viết này sẽ trình bày nguyên nhân và cách để giải quyết vấn đề đó.

## Giảm độ trễ của Wine

Lý do khiến Wine khởi động chậm là do các font chữ trên hệ thống (tham khảo [Wine starts slowly due to font abundance](https://askubuntu.com/questions/1237065/wine-starts-slowly-due-to-font-abundance) và [Wine startup time](https://forum.winehq.org/viewtopic.php?t=23294)). Do đó, cách xử lý sẽ là che giấu font chữ trên hệ thống khỏi Wine. Việc này được thực hiện bằng cách tạo ra một file cài đặt phông chữ dành riêng cho Wine, và bắt các lệnh liên quan tới Wine sử dụng file này.

{{<notice warning>}}
Mặc dù không bắt buộc, kinh nghiệm làm việc với shell và biến môi trường sẽ hữu ích khi thực hiện hướng dẫn này.
{{< /notice >}}

Các bước thực hiện:
1. Chuẩn bị một thư mục để lưu file
1. Tạo file font config
1. Tạo các script tương ứng với các file của Wine, nhưng dùng file config ở trên thay vì file config font của hệ thống
1. Cấu hình hệ thống để dùng các file script ở trên thay vì dùng file gốc của Wine

### Chuẩn bị file config

Trước hết, chuẩn bị một thư mục trống để lưu trữ các file. Bài viết này sử dụng đường thư mục `~/Application/wine-override`. Nếu không nói gì khác, các bước tiếp theo được thực hiện trong thư mục này.

Sau đó, ta cần tạo một file `fonts.conf` với nội dung như sau:
```xml
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<!-- /etc/fonts/fonts.conf file to configure system font access -->
<fontconfig>
    <its:rules xmlns:its="http://www.w3.org/2005/11/its" version="1.0">
    <its:translateRule translate="no" selector="/fontconfig/*[not(self::description)]"/>
    </its:rules>
</fontconfig>
```


### Tạo các script cho Wine

Để bắt Wine sử dụng file này, ta đặt biến môi trường `FONTCONFIG_FILE` cho các câu chương trình liên quan tới Wine. Việc đặt biến này được thực hiện trong một script thay thế Wine. Ví dụ, với lệnh `wine`, ta có script như sau:
```bash
FONTCONFIG_FILE=/path/to/fonts.conf /path/to/wine $@
```

Tuy nhiên, vì Wine có khá nhiều chương trình thực thi, ta tìm cách để sinh ra các script này thay vì viết thủ công từng file một. Ta tạo một file `template.sh` như sau:
```bash
WINE_BINARY_DIR=/opt/wine-staging/bin
COMMAND="$(basename $0)"
OVERRIDE_DIR="$(dirname $(realpath $0))"
FONTCONFIG_FILE="$OVERRIDE_DIR/fonts.conf" "$WINE_BINARY_DIR/$COMMAND" $@
```
Trong đó, `WINE_BINARY_DIR` là thư mục mà chứa các chương trình của WINE. Thư mục này sẽ có thể được tìm bằng lệnh:
```bash
dirname $(which wine)
```
**Lưu ý:** Các máy khác nhau sẽ cài Wine ở các vị trí khác nhau, do đó độc giả cần tự tìm thư mục cài đặt Wine trên máy mình và thay thế biến `WINE_BINARY_DIR` ở script trên.

Ta gắn quyền thực thi cho script trên bằng lệnh:
```bash
chmod 755 template.sh
```

Trong file trên, biến `$0` là đường dẫn của file script. Vì trong hướng dẫn, file được để là `template.sh` và được đặt trong thư mục `~/Application/wine-override/`, biến `$0` có giá trị là `~/Application/wine-override/template.sh`. Do đó, biến `COMMAND` sẽ chứa tên câu lệnh (`template.sh`), và biến `OVERRIDE_DIR` chứa đường dẫn tới thư mục.

```bash
# Câu lệnh ví dụ, đừng chạy
ln -s $(realpath template.sh) ~/.local/bin/wine
```
Giả sử ta `symlink` file `template.sh` tới `~/.local/bin/wine` như trong câu lệnh trên thì `$0` có giá trị `~/.local/bin/wine`, `COMMAND` nhận giá trị `wine`, và `$WINE_BINARY_DIR/$COMMAND` sẽ trỏ tới chương trình thực thi `wine` nguyên gốc cài trên hệ thống. Vì ta sử dụng `realpath`, biến `OVERRIDE_DIR` vẫn trỏ tới thư mục chứa file `fonts.conf` và `template.sh`, và biến `FONTCONFIG_FILE` vẫn sẽ trỏ tới file `fonts.conf` mà ta chuẩn bị ở trên.

Do đó, ta chỉ cần `symlink` file `template.sh` này tới một file mà có tên trùng với các file thực thi của `wine`. Ta sẽ dùng một script khác để làm vậy:
```bash
#!/bin/sh

PREFIX="$HOME/.local"
WINE_COMMANDS="msidb
msiexec
notepad
regedit
regsvr32
widl
wine
wine-preloader
wine64
wine64-preloader
wineboot
winebuild
winecfg
wineconsole
winecpp
winedbg
winedump
winefile
wineg++
winegcc
winemaker
winemine
winepath
wineserver
wmc
wrc"

for COMMAND in $WINE_COMMANDS; do
    echo "Installing $COMMAND to $PREFIX/bin/$COMMAND"
    ln -sf $(realpath template.sh) $PREFIX/bin/$COMMAND
done
```
Lưu script với tên `links.sh`. Sau đó, ta chạy script để tiến hành `symlink` các câu lệnh:
```bash
chmod 755 links.sh
./links.sh
```

Sau khi chạy xong, file `template.sh` sẽ được link vào các file như `wine`, `winecfg`, `wineboot`, ... trong thư mục `~/.local/bin`. Ta chỉ cần cấu hình để hệ thống dùng các file trong thư mục này.

### Winetricks và các chương trình khác

Nếu sử dụng `winetricks` hay các chương trình hỗ trợ Wine khác, ta cũng cần tạo script cho các chương trình này. Ví dụ, với winetricks, ta tạo một script với tên `winetricks` và nội dung như sau:
```bash
BASE="$(dirname $(realpath $0))"
FONTCONFIG_FILE="$BASE/fonts.conf" /bin/winetricks $@
```

Trong đó `/bin/winetricks` là vị trí của chương trình `winetricks` thật. Sau đó, ta gán quyền thực thi và link nó như script `template.sh`:
```bash
chmod 755 winetricks
ln -s $(realpath winetricks) ~/.local/bin/winetricks
```

### Cấu hình hệ thống

Mục đích của bước này là làm hệ thống ưu tiên các file trong `~/.local/bin`. Ta đặt biến môi trường `PATH` bằng các thêm dòng sau vào các file như `.bashrc`, (`.zshenv` nếu dùng `zsh`), `.profile`, `.xsessionrc`:
```bash
export PATH="$HOME/.local/bin:$PATH"
```

Sau khi thêm xong, hãy thoát đăng nhập và đăng nhập lại (hoặc khởi động lại máy). Sau đó, chạy `echo $PATH` để kiểm tra xem biến `PATH` có chứa thư mục `~/.local/bin` hay không. Ngoài ra, đường dẫn `~/.local/bin` phải đứng trước các đường dẫn khác.

Ta cũng có thể kiểm tra bằng cách chạy `which wine`. Nếu cài đặt thành công thì đường dẫn trả ra sẽ là `/home/<tên người dùng>/.local/bin/wine`.

### Thiết lập Wine và kiểm tra

Sau khi thực hiện xong tất cả bước trên, ta reset Wine bằng cách xóa thư mục `WINE_PREFIX` (thường là `~/.wine`). Sau đó thiết lập lại Wine bằng lệnh `wineboot`:
```bash
rm ~/.wine -rf
wineboot -u
```

Sau khi lệnh trên chạy xong, ta có thể kiểm tra kết quả bằng cách mở Notepad (chạy `wine notepad`). Nếu thành công, Notepad sẽ mở rất nhanh chóng, và menu `Edit > Font` của Notepad sẽ chỉ bao gồm một số phông chữ cơ bản trên Windows.

*Lưu ý*: nếu vô tình chạy `wine` mà không giấu font hệ thống, `wine` sẽ lưu lại các font đó và lại bị chậm. Khi đó ta cần xóa thư mục `~/.wine` và thiết lập lại Wine.

## Liên kết tham khảo

- https://forum.winehq.org/viewtopic.php?t=23294
- https://askubuntu.com/questions/1237065/wine-starts-slowly-due-to-font-abundance
- https://gist.github.com/rmi1974/0a613d721851fef4cb6babd02d65a97c
