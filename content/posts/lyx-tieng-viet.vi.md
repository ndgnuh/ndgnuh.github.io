---
title: "Lyx và văn bản tiếng Việt"
date: 2020-05-28T22:52:30+07:00
summary: "Cách gõ và build văn bản tiếng Việt với LyX"
draft: false
tags:
- linux
- foss
- lyx
- latex
- tex
keywords:
- lyx
- ubuntu
- linux
- foss
- mã nguồn mở
- tự do
series:
- lyx
---

Bài viết trước đã giới thiệu về cách dùng cơ bản của LyX. Tuy nhiên, vì cách mà LaTeX hoạt động, chúng ta chưa thể tạo được một văn bản tiếng Việt ngay được. Bài viết này sẽ trình bày những cách để tạo văn bản tiếng Việt trong LyX.

## Sử dụng PDFLatex

Khi dùng `pdflatex`, những gói LaTeX bổ trợ cần phải được sử dụng khi muốn gõ tiếng Việt. Cụ thể hơn, có hai gói thường hay sử dụng, đó là `vntex` và `babel`.

### Với VNTex

Nếu hệ điều hành hỗ trợ phân phối cả những gói của LaTeX, gói `vntex`  thường được phân  phối qua một gói ngôn ngữ, vĩ dụ như trên Arch Linux thì nó nằm đâu đó trong gói `texlive-langextra` (xem [tại đây](https://wiki.archlinux.org/index.php/TeX_Live)). Nếu hệ điều hành không phân phối gói của LaTeX, bạn có thể sử dụng trình quản lý gói của TeXLive để cài đặt:

```
# giả sử texlive được cài đặt đúng cách
# chạy cái này trong terminal hoặc cmd
tlmgr install vntex
```

Nèu vì một lý do nào đó mà bạn không có quyền ghi vào thư mục cài đặt, hãy dùng `--usermode` để cài đặt riêng cho người dùng của mình

Sau khi cài đặt xong, hãy mở văn bản của bạn trên `lyx`, ấn tổ hợp phím `Alt + D`, sau đó nhấn `S` (hoặc dùng chuột click vào Document > Settings). 

Click vào phần `preamble` ở góc dưới bên trái. Sau đó viết vào vùng trắng ở bên cạnh:

```latex
\usepackage[utf8]{vietnamese}
```

![](/img/lyx-vn-001.png)

Tiếp theo, hãy mở phần Language và chỉnh ngôn ngữ thành Vietnamese (như trong hình)
 
![](/img/lyx-vn-002.png)


Sau đó nhấn Apply (`Alt + A`) và văn bản này sẽ compile bình thường.

### Với Babel

Để dùng Babel bạn cần phải có gói `babel-vietnamese`

```
tlmgr install babel-vietnamese
```

Phương pháp với Babel thì không cần phải cài đặt thủ công phần preamble như trên. Bạn chỉ cần vào phần cài đặt văn bản (`Alt + D, S`), sau đó qua phần language và chỉnh ngôn ngữ thành Vietnamese.

![](/img/lyx-vn-003.png)

Phần encoding bạn có thể chọn: `Language default`, `Unicode (ucs - extended) (utf8x)` hoặc `Unicode (XeLaTeX)`. Tuy nhiên bạn với hai tùy chọn đầu bạn có thể sẽ phải cài thêm gói `ucs` từ LaTeX.
```
tlmgr install ucs
```

## Sử dụng XeLaTeX, LuaLaTeX

Compile tiếng Việt với hai TeX engine này khá đơn giản. Trong cài đặt văn bản, hãy nhấn vào phần `Font` và đánh dấu ô `Use non-Tex fonts` như trong ảnh.

![](/img/lyx-vn-004.png)

Bạn có thể tiếp tục dùng font mặc định của LaTeX hoặc sử dụng một font trên máy bạn. Với LuaLaTeX, nếu bạn gặp lỗi về font, hãy cài gói `luaotfload`. Gói này cần cho việc load font của LuaLaTeX.

```
tlmgr install luaotfload
# cập nhật lại hệ thống load font
luaotfload-tool --update
```

Trong LuaLaTeX, có một lỗi khiến cho font Latin Modern Roman (font mặc định) không thể tìm thấy được (hên xui gặp phải). Cách xử lý là bạn cài gói `lm` (đề phòng trường hợp bạn chưa có font này)
```
tlmgr install lm
```

Nếu việc compile vẫn lỗi. Hãy vào thư mục cài đặt font Latin Modern Roman của LaTeX (`<thư mục cài LaTeX>/texmf-dist/fonts/opentype/public/lm/`) và cài đặt những font đó lên máy bạn. Trên \*Nix bạn chỉ cần symlink thư mục đó tới `/usr/share/fonts/` (trong ví dụ sẽ symlink toàn bộ thư mục font của LaTeX vào hệ thống)
```sh
# cả hệ thống
ln -s $(realpath <thư mục LaTeX>/texmf-dist/fonts/) /usr/share/fonts/LaTeX
# một người dùng
ln -s $(realpath <thư mục LaTeX>/texmf-dist/fonts/) ~/.local/share/fonts/LaTeX
```

Cuối cùng, trong phần cài đặt, chuyển sang phần `Format` và chọn `Output Format` là `Pdf (LuaLaTeX)` hoặc `Pdf (XeLaTeX)` theo ý muốn của bạn.

![](/img/lyx-vn-005.png)

## Lưu lại thay đổi cho văn bản sau này

Nếu bạn phải làm việc với văn bản tiếng Việt thường xuyên, việc phải chỉnh Language mỗi khi viết văn bản mới sẽ rất bất tiện. LyX cung cấp chức năng lưu lại những tùy chọn của bạn và dùng nó cho những văn bản mới. Để làm việc này, bạn chỉ cần vào cài đặt văn bản (`Alt + D, S`), sau đó nhấn `Save as document defaults`. Những văn bản bạn tạo ra *sau đó* sẽ mặc định có những tùy chọn như bạn đã thiết lập.

![](/img/lyx-vn-006.png)

## Kết luận

Đến đây thì việc build một văn bản tiếng Việt trong LyX không còn là vấn đề. Các bộ gõ tiếng Việt cũng hoạt động khá tốt trên LyX. Riêng với người dùng \*Nix, nếu bạn dùng Ibus Unikey, chế độ preedit có thể hơi khó chịu một chút vì phải commit trước khi dùng phím tắt. Theo tôi, cách ổn nhất là dùng [Ibus Bamboo](https://github.com/BambooEngine/ibus-bamboo), hãy chuyển sang chế độ 5 (forward as commit), vừa có thể gõ rất ổn và vừa có thể dùng được phím tắt.

Nếu bạn muốn tìm hiểu thêm về tiếng Việt trong LaTeX thì có thể tham khảo bài viết http://vntex.sourceforge.net/doc/vn-fonts.html
