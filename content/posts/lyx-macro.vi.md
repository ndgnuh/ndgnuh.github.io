---
title: "Gõ tắt sử dụng macro trong Lyx"
date: 2020-08-20T16:12:00+07:00
summary: "Cách sử dụng Macro trong LyX. Các loại macro hay xuất hiện. Một số mẹo khi sử dụng."
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
- macro
- word
- soạn thảo
- tex
- latex
- math
series:
- lyx
---

LyX cung cấp khả năng tương thích với mọi lệnh trong môi trường toán của TeX. Khi có những biểu thức toán dài và lặp lại nhiều lần, ta tạo ra một macro trong TeX để rút gọn câu lệnh và tiết kiệm thời gian. Trong LyX cũng hỗ trợ tạo những macro cho môi trường toán, tuy nhiên cấu trúc của macro trong LyX hơi khác một chút.

## Sử dụng macro

### Tạo một macro

Macro trong LyX được tạo bởi phím tắt `Alt-I + H + O` (`Insert > Math > Macro`). Macro trong LyX gồm ba phần:
- Phần tên (Name)
- Phần câu lệnh (TeX)
- Phần hiển thị (LyX)

![](/img/lyx-macro-001.png)

Phần tên là câu lệnh rút gọn mà ta cần tạo. Phần câu lệnh chính là phần code LaTeX sẽ được dùng khi tạo văn bản. Phần hiển thị chỉ là phần mà LyX sẽ hiển thị cho chúng ta khi dùng câu lệnh đó, phần này không ảnh hưởng tới văn bản được tạo ra. Nếu để trống phần hiển thị thì LyX sẽ mặc định hiển thị những thứ trong phần TeX.

### Macro có tham số

Nhiều khi, biểu thức toán lặp lại nhiều lần với cấu trúc gần giống nhau, chỉ khác nhau một chút. Đó là lúc chúng ta cần tới tham số. Để chèn tham số trong macro, chúng ta chèn `\#<thứ tự tham số>` vào nơi muốn đặt tham số đó. Ví dụ:

![](/img/lyx-macro-002.png)
Trong hình định nghĩa macro `\ang`, với 2 tham số đặt trong ngoặc nhọn.

## Một số loại macro thường dùng

### Macro toán tử, macro hàm

Trong LaTeX chúng ta định nghĩa một toán tử bằng `\operatorname`. Tuy nhiên LyX không cung cấp hiển thị cho lệnh này, lý do vì không cần thiết. Khi muốn tạo một toán tử trong LyX, chúng ta tạo một macro với phần TeX là `\operatorname{<tên toán tứ>}` và dùng `\mathrm` ở phần hiển thị để toán tử hiển thị gọn gàng khi edit. Hình minh họa một macro với tên `\name` được định nghĩa, tạo ra một toán tử tên "name", và sẽ hiển thị là `\mathrm{name}` trên trình soạn thảo.

![](/img/lyx-macro-001.png)

*Tuy dùng `\mathrm` có vẻ nhanh nhưng `\mathrm` trong văn bản cuối sẽ gây ra sai khoảng cách, do đó chỉ dùng `\mathrm` để hiển thị trong LyX chứ không dùng `\mathrm` cho tên hàm, toán tử trong TeX.*

Có thể vì ký hiệu khá đa dạng, LyX (và có thể cả TeX) không định nghĩa sẵn một số hàm lượng giác (hyperbolic) ngược, do đó chúng ta cần tự định nghĩa bằng macro:
![](/img/lyx-macro-001b.png)

### Macro ngoặc (khó dịch, delimiters)

Những cặp ngoặc như `(){}[]||` trong LyX được gọi chung là Delimiters. Ngoài những cặp ngoặc này ra chúng ta còn những cặp thường dùng khác nhưng không được gắn phím tắt mặc định. Ví dụ như:

![](/img/lyx-macro-003.png)

Những cặp ngoặc này có thể được chèn bằng `Alt-I + R` hoặc `Insert > Math > Delimiters...`, hộp thoại chèn delimiter có cấu trúc như sau:
![](/img/lyx-macro-004.png)
- Ô chọn ngoặc trái phải
- Câu lệnh TeX tương ứng
- Keep matched khi được đánh dấu sẽ làm cho ngoặc trái với ngoặc phải cùng loại với nhau.
- Swap & Reverse đổi chỗ ngoặc trái và phải.
- Size là kích cỡ ngoặc, chọn variable để ngoặc kéo dài bao phủ hết phần bên trong ngoặc.

Dưới đây là các macro tương ứng với hình ở trên. Ngoặc trái của lệnh `\sub` được chọn là `(none)`, tức là không có ngoặc.
![](/img/lyx-macro-005.png)

### Macro alias

Khi có một lệnh dài nhưng xuất hiện nhiều lần, ta tạo alias cho nó bằng macro để tăng tốc độ soạn thao. Ví dụ, các tập số thường được kí hiệu bằng `\mathbb{tên}` (ví dụ như `\mathbb{R}`). Dù LyX có hỗ trợ nhưng tần suất xuất hiện của lệnh này khá cao, dẫn đến chậm khi gõ. Do đó, để tiện thì chúng ta có thể định ra macro với một chữ cái cho các tập số:
![](/img/lyx-macro-006.png)

## Lưu macro thường dùng

Sau một thời gian sử dụng, số macro cần dùng sẽ tăng lên kha khá. Do đó copy hoặc víết tất cả macro với mỗi văn bản cần dùng macro đó sẽ phiền vô cùng. LyX khắc phục điều này với hệ thống *Child document* (nói thêm sau).

Đầu tiên, chúng ta cần lưu macro vào một file LyX. File này không có gì ngoài Macro. Giả sử file này có tên `macro.lyx`, với mỗi văn bản mà ta cần dùng macro, ta chèn file `macro.lyx` trên đầu của file hiện tại bằng cách di con trỏ soạn thảo lên đầu (`Ctrl-Home`), sau đó nhấn tổ hợp phím `Alt-I + E + D` (hoặc `Insert > File > Child Document...`). Tại hộp văn bản hiện ra:
![](/img/lyx-macro-007.png)
1. Nhấn vào browse, tìm và chọn file `macro.lyx`.
2. Chọn `Input` tại `include type`
3. Nhấn `Ok` để đóng hộp thoại

Sau đó, tất cả macro sẽ tự nhiên hoạt động trong văn bản một cách kì diệu :)

## Kết luận
Cũng như việc dùng phím tắt ra, macro tăng tốc độ soạn thảo văn bản lên đáng kể. Ngoài ra còn một số lưu ý nhỏ sau khi tạo macro:
- Kiểm tra xem macro đó có được định nghĩa bởi LaTeX hay không (nếu nó được định nghĩa trước thì tạo macro có thể gây lỗi). Cách dễ nhất là xóa macro đi, tạo môi trường toán và thử xem lệnh đó có tồn tại hay không.
- Macro cũng như lệnh trong môi trường toán, do đó cũng có thể được sử dụng với phím tắt như một lệnh toán (dùng `math-insert <tên macro>`)
