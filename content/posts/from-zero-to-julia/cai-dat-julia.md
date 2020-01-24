---
title: "Julia từ con số không: hướng dẫn cài đặt Julia"
date: 2020-01-20T19:26:13+07:00
draft: false
description: "Cách tải và cài đặt Julia"
summary: "Đây là bài viết đầu tiên của series Julia từ con số không. Trong bài học này mình sẽ hướng dẫn các bạn cách tải và cài đặt Julia"
tags: 
- hướng dẫn
- julia
---
Chào mừng các bạn đến với bài viết đầu tiên của series "Julia từ con số không". Trong bài viết này mình sẽ hướng dẫn các bạn cách tải và cài đặt Julia.

Nội dung chính:

- [Chuẩn bị](#chuẩn-bị)
- [Sử dụng bản phân phối chính thức](#sử-dụng-bản-phân-phối-chính-thức)
    - [Tải Julia](#tải-julia)
    - [Hướng dẫn cài đặt cho Windows](#hướng-dẫn-cài-đặt-cho-windows)
    - [Hướng dẫn cài đặt cho MacOS](#hướng-dẫn-cài-đặt-cho-macos)
    - [Hướng dẫn cài đặt cho *Nix (Linux, BSD)](#hướng-dẫn-cài-đặt-cho-nix-linux-bsd)
- [Sử dụng bản phân phối cộng đồng](#sử-dụng-bản-phân-phối-cộng-đồng)
- [Tổng kết](#code-bằng-cái-gì)

## Chuẩn bị

Để cài Julia, chúng ta có 2 cách:
- Cài đặt từ bản phân phối chính thức: cách này được khuyến cáo vì nó sẽ không gây lỗi lặt vặt, tuy nhiên quá trình cài đặt sẽ hơi dài một chút.
- Cài đặt từ bản phân phối của cộng đồng: cách này rất đơn giản, đặc biệt với những bạn dùng Linux. Tuy nhiên cách này có thể gây lỗi vặt (thực ra mình mới chỉ thấy một lỗi trên ArchLinux, chưa thấy có người gửi issue nào khác)

Việc cài đặt có thể sử dụng tới terminal (dòng lệnh, hiểu nôm na là vậy), vậy có kiến thức cơ bản về việc sử dụng terminal và shell có thể sẽ hữu dụng và giúp quá trình cài đặt dễ dàng hơn.

## Sử dụng bản phân phối chính thức

### Tải Julia

Đầu tiên bạn cần tải bản phân phối tương ứng với hệ điều hành của mình Julia tại https://julialang.org/downloads. Có ba lựa chọn cơ bản cho bạn tải:

- *Current stable release*: là phiên bản ổn định hiện tại
- *Long term support*: là phiên bản hỗ trợ lâu dài, hiểu nôm na nó là bản *rất ổn định*
- *Upcoming release*: là ứng cử viên phiên bản cho phiên bản ổn định sắp tới

Bạn nào ngại đọc tiếng Anh thì có thể đọc hướng dẫn từng-bước ở đây:

1. Truy cập trang https://julialang.org/downloads
2. Tìm đề mục tương ứng với những lựa chọn ở trên (Current stable release, Long term support,...)
3. Chọn file tương ứng với hệ điều hành của mình:
    - Chọn phiên bản 32-bit \& 64-bit tương ứng
    - Nếu dùng windows hãy chọn  `windows (.exe)`
    - Nếu dùng MacOS hãy chọn  `MacOS 10.8+ (.dmg)`
    - Nếu bạn dùng Linux hoặc BSD hãy chọn bản cài tương ứng với cấu trúc máy tính của mình. Nếu bạn không biết chọn cái nào thì *khả năng rất cao* là bạn nên chọn  `Generic Linux/FreeBSD Binaries for x86`
    - Chọn bản 32-bit hoặc 64-bit tương ứng máy bạn

Nếu bạn là một người thích chơi ở mức khó, bạn có thể thử bản Nightly tại [đây](https://julialang.org/downloads/nightlies.html) nếu bạn thích tùy chỉnh thì có thể tự compile Julia, mã nguồn có trong [trang download](https://julialang.org/downloads) và cả trên [github](https://github.com/JuliaLang/julia/releases)

### Hướng dẫn cài đặt cho Windows
Julia hỗ trợ Windows 7 trở lên, bạn có thể cài đặt theo các bước sau:
1. Sau khi tải file `.exe` từ trang chủ về, hãy mở file `.exe` lên để tiến hành cài đặt. Nếu bạn muốn cài Julia cho mọi người dùng trên hệ thống hãy chạy file `.exe` với tư cách Administrator.
2. Khi bộ cài sẵn sàng, nhấn `Next`, chọn thư mục bạn muốn cài Julia (hãy copy đường dẫn ra notepad hoặc chỗ nào đó để dùng sau này). Sau đó, nhấn `Install` để cài.
3. Sau khi cài xong, bạn có 3 lựa chọn, hãy chọn theo ý thích:
    - Open Julia install folder: mở thư mục cài Julia
    - Create Start Menu folder and shortcut: tạo đường dẫn ở Start Menu
    - Create desktop shortcut: tạo đường dẫn ở desktop
4. Chọn `Finish`, nếu bạn muốn chạy Julia từ terminal hãy làm những bước sau. Nếu không có thể click vào icon Julia để chạy.
5. Nhấn tổ hợp phím `Windows + R`, gõ `sysdm.cpl` và nhấn `Enter`
6. Một cửa sổ hiện lên, hãy chọn thẻ `Advanced`, chọn `Environment Variables`.
7. Thêm một cửa sổ nữa hiện lên, trong phần `System variables`, chọn `Path` và click vào nút `Edit`
8. Đến đây có sự khác biệt giữa Windows 7 và 10 (mình sẽ giả sử không ai dùng Windows 8)
    - Nếu bạn dùng Windows 7:
        1. Sau khi nhấn `Edit`, sẽ có một cửa sổ với 2 hộp văn bản xuất hiện.
        2. Click vào hộp văn bản thứ 2 (`Variable value:`) và di chuyển đến cuối dòng, nếu cuối dòng không có dấu `;` hãy thêm dấu `;` vào.
        3. Lấy đường dẫn cài đặt ở bước 2 ra, thêm `\bin` vào đuôi và **copy thêm vào cuối** của hộp văn bản thứ 2. Ví dụ mình cài Julia vào `E:\julia`, mình sẽ ghi thêm `E:\julia\bin` vào cuối. Nhắc lại rất kĩ là **ghi thêm** nhé, ông nào paste đè lên cái cũ xong hỏng máy tôi không chịu trách nhiệm đâu.
    - Nếu bạn dùng Windows 10:
        1. Một cửa sổ hiện ra, nhấn `New`. Một cửa sổ mới hiện ra với một hộp văn bản
        2. Lấy đường dẫn cài đặt ở bước 2 ra, thêm `\bin` vào đuôi và copy vô cái hộp văn bản đó. Ví dụ mình cài Julia vào `E:\julia`, mình sẽ ghi `E:\julia\bin`.
9. Ấn `Ok`, tắt hết các hộp thoại, giờ bạn đã cài xong Julia. Bạn có thể mở `cmd` hoặc `Powershell` và chạy lệnh `julia` để bắt đầu nghịch.

{{< notice note >}}
Người dùng Windows 7 và Windows Server 2012 cần cài thêm một số thứ để Julia thực sự hoạt động:
{{< /notice >}}

- [bản update này](https://support.microsoft.com/en-us/help/3140245/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-wi) sẽ giúp trình quản lý gói của Julia hoạt động. Xuống phần `Method 2` và click vào link [Microsoft Update Catalog](https://support.microsoft.com/en-us/help/3140245/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-wi).
- [Windows Management Framework 3.0 hoặc hơn](https://docs.microsoft.com/en-us/powershell/scripting/wmf/overview) để cài Powershell. Vào trang web trên, kéo xuống dưới cái bảng và click vào phiên bản bạn muốn download.
- Bạn nên cài một terminal khác ngoài `cmd.exe` vì nó có một số vấn đề gây ảnh hưởng tới chức năng của Julia.

### Hướng dẫn cài đặt cho MacOS
*Phần này cần cần các bạn phản hồi, mình không có MacOS nên chưa kiểm thử.*
1. Mở file `.dmg` bạn tải về, bên trong có file `Julia-<phiên-bản>.app`. Kéo thả file này vào thư mục `Application`.
2. Nếu bạn cần chạy Julia từ terminal, chạy `open -a TextEdit ~/.bash_profile` (nếu dùng `zsh` thì thay `.bash_profile` bằng `.zshrc`)
3. Thêm dòng `export PATH="/Applications/Julia-.app/Contents/Resources/julia/bin:${PATH}"` vào cuối và save lại

Giờ bạn có thể chạy Julia bằng cách click vào icon hoặc chạy lệnh `julia` trong terminal

### Hướng dẫn cài đặt cho *Nix (Linux, BSD)
1. Sau khi tải file `.tar.gz` từ trang chủ về, bạn có thể giải nén nó bằng bất kì công cụ nào bạn muốn, cách đơn giản nhất là dùng lệnh:
```shell
tar -xvzf đường/dẫn/tới/julia-<thay-chỗ-này-giống-tên-file-của-bạn>.tar.gz
```
2. File được giải nén tới một thư mục `julia-<phiên-bản>`. Mình sẽ gọi cái này là `<julia dir>`. Bạn có thể copy thư mục này tới vị trí cài đặt mong muốn.
3. Giờ bạn có 3 lựa chọn như dưới đây

#### Cài đặt cho người dùng của bạn
Thêm thư mục Julia vào biến `$PATH` bằng cách thêm dòng sau:
```shell
export PATH="$PATH:/đường/dẫn/tới/<julia dir>/bin"
```
vào `~/.bashrc` và `~/.bash_profile`. Nếu bạn dùng `zsh` thì phải thêm vào `~/.zshrc`. Nếu bạn dùng các shell khác nữa thì mình không biết, sorry.

Sau khi tắt terimnal đi và bật lại thì bạn có thể chạy `julia` để kiểm tra.
#### Cài đặt trên toàn hệ thống
Cách 1: tạo đường dẫn từ file `julia` tới một trong những thư mục nằm trong biến PATH.
1. Chạy `echo $PATH` xem có những thư mục nào. Ở đây mình sẽ chọn `/usr/bin`
2. Chạy lệnh `sudo ln -s /đường/dẫn/tới/<julia dir>/bin/julia /usr/bin/`

Cách 2: thêm thư mục `Julia` vào biến `PATH`. Các bạn làm như phần cài đặt cho người dùng, nhưng thay vì thêm vô file `.bashrc` hay `.zshrc`, hãy thêm vào file `/etc/profile`, `/etc/bashrc` và `/etc/zshrc`.

Với cách 1 thì bạn có thể chạy `julia` ngay lập tức mà không cần restart cái terminal.
#### Cách cục súc
Chạy `/đường/dẫn/tới/<julia dir>/bin/julia` mỗi lần bạn dùng đến nó.

## Sử dụng bản phân phối cộng đồng

Ngoài cách cài đặt từ bản cài từ trang chủ, chúng ta có thể cài từ các bản phân phối ngoài. Những bản phân phối này do cộng đồng người dùng Julia đóng góp. Lưu ý rằng, dù cài những bản không chính thức này rất dễ dàng, việc cài Julia từ bản phân phối chính thức vẫn được khuyến cáo hơn.

### Chocolately trên Windows
Cài đặt:
```shell
choco install julia --confirm
```
Cập nhật:
```shell
choco upgrade julia --confirm
```

### HomeBrew trên Mac

```shell
brew cask install julia
```

### Fedora/Red hat/Cent OS và các distro tương tự

Với Fedora bản 19 hoặc hơn:
```shell
sudo dnf copr enable nalimilan/julia
sudo yum install julia
```

Nếu bạn dùng Cent OS bản 7 hoặc hơn:
```shell
sudo yum-config-manager –add-repo https://copr.fedorainfracloud.org/coprs/nalimilan/julia/repo/epel-7/nalimilan-julia-epel-7.repo
sudo yum install julia
```

Nếu `dnf` và `yum-config-manager` không khả dụng trên hệ thống của bạn, hãy tải file `.repo` tương ứng ở link phía trên và copy vào `/etc/yum.repos`, sau đó chạy câu lệnh thứ 2.

Để cập nhật Julia:
```shell
yum upgrade julia
```

### Debian/Ubuntu và các distro tương tự

Cài đặt:
```shell
sudo apt update
sudo apt install julia
```
Cập nhật:
```shell
sudo apt update
sudo apt upgrade
```

### Archlinux và các distro tương tự

Cài đặt:
```shell
sudo pacman -S julia # bản không chính thức
# những bản này cần `yay` để cài tự động
sudo yay -S julia-bin # tương ứng với bản chính thức từ trang chủ
yay -S julia-git # tương ứng vởi bản build từ git
```
Cập nhật:
```shell
sudo pacman -Syu
# hoặc
yay -Syu
```

## Tổng kết
Các bạn có thể cài đặt Julia theo cách mình muốn. Bản cài chính thức cài đặt sẽ dài dòng hơn một chút nhưng đảm bảo hơn, bản cài do cộng đồng phân phối sẽ tiện lợi hơn với một tỉ lệ rất rất nhỏ xảy ra bug.

Sau khi đã thoải mái với cài đặt của mình. Ở phần tiếp theo mình sẽ nói đến một số công cụ có thể dùng để lập trình Julia.
