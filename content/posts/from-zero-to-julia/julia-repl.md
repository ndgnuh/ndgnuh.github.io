---
title: "Julia từ con số không: Julia REPL"
date: 2020-01-20T23:59:00+07:00
summary: "Bài viết thuộc series Julia từ con số không, giới thiệu về việc sử dụng chế độ tương tác với Julia (Julia REPL)"
draft: true
tags:
- hướng dẫn
- julia
libraries:
- katex
- highlight
---

Ở phần đầu tiên của series "Julia từ con số không", chúng ta đã tiến hành [cài đặt Julia](../cai-dat-julia). Giờ chúng ta sẽ bắt đầu làm việc với giao diện cơ bản nhất của Julia: REPL.

## REPL là gì?

REPL là viết tắt của Read - Eval - Print - Loop, hay Đọc - Thực Thi - In Kết Quả - Lặp Lại. Nói một cách dễ hiểu, bạn nhập một dòng lệnh vào, Julia sẽ thực thi dòng lệnh đó, in ra kết quả và quá trình này lặp đi lặp lại đến khi bạn chán thì dừng.

Giả sử bạn cài đặt Julia như trong hướng dẫn. Để mở REPL, hãy chạy `julia` trong terminal hoặc nhấp đúp vào icon Julia. Bạn sẽ được chào đón bởi màn hình sau:

![ảnh minh họa](/img/julia-repl-001.png)

Gõ `print("Hello world")` và ấn Enter. Vậy là bạn đã viết xong hello world bằng Julia rồi! Qua ví dụ này chắc bạn cũng hiểu rõ cách chạy lệnh trong REPL rồi. Để thoát REPL, bạn có thể nhấn tổ hợp phím `Ctrl + D` khi đang có một dòng trống, hoặc chạy lệnh `exit()`.

Sau đây mình sẽ giới thiệu một số tính năng của Julia REPL, bao gồm những tính năng tiêu chuẩn và cả những tính năng cực kì độc mà (mình nghĩ) chỉ Julia có.

## Các tính năng 

### Tab completion

Tính năng này khá quen thuộc nếu bạn đã từng làm việc với bất kì dạng REPL nào. Bạn gõ vài thứ, ấn `tab`, một danh sách những thứ có thể viết sẽ hiện ra, nếu chỉ có một lựa chọn thì lựa chọn đó sẽ được tự động điền.

Tuy nhiên, REPL của Julia có một thứ khá độc. Bạn hãy gõ `\cup` và nhấn `tab` trên REPL, sau đó nhấn Enter.

![ảnh minh họa](/img/julia-repl-002.png)

Giờ có hai vấn đề chúng ta cần quan tâm ở đây: *"kí tự lạ" trông giống như chữ `u` vừa xuất hiện* và *nếu nó là kí tự lạ, tại sao Julia không báo lỗi?*. Thứ nhất, kí tự trên thực chất là kí hiệu phép hợp trong toán học. $$ \\{1, 2\\} \cup \\{4\\} = \\{1, 2, 4\\} $$
Thứ hai, Julia **hỗ trợ** tên biến và tên hàm chứa kí tự unicode, và `∪` là một hàm hoàn toàn hợp lệ. Nếu không tin hãy chạy thử:

```julia
julia> [1, 2] ∪ 4 ∪ [5, 9]
5-element Array{Int64,1}:
 1
 2
 4
 5
 9
```

Những kí hiệu này bình thường sẽ không được dùng khi lập trình, tuy nhiên trong những công thức toán phức tạp, chúng sẽ rất hữu dụng cho việc biểu đạt code. Vậy làm thế nào để sử dụng những kí tự này? Rất đơn giản, chúng đều được định danh bằng tên trong LaTeX. Nếu không nhớ rõ tên bạn có thể gõ `\` và nhấn `tab` để tab completion gợi ý cho bạn.

Ví dụ nhỏ về cách dùng: `\sigma<tab>(x) = one(x) / (one(x) + exp(-x))`:

```julia
julia> σ(x) = one(x) / (one(x) + exp(-x))
σ (generic function with 1 method)
```

> Nhưng nếu không ở trong REPL thì tạo mấy kí tự này kiểu gì?

Các bạn yên tâm, tất cả các công cụ dành cho Julia đều hỗ trợ tính năng này. Do đó khi các bạn dùng editor/ide/jupyter notebook cũng chỉ cần thao tác tương tự như trên là có thể tạo ra được các kí tự đặc biệt.

{{< notice note >}}
Đối với các bạn dùng Windows, nếu các bạn gặp lỗi khi in ra những kí tự đặc biệt này (in ra ô vuông, không in ra cái gì), mình khuyên các bạn dùng một thứ gì khác ngoài cmd và powershell. Tại sao? Vì hai cái này gặp vấn đề trong việc render các kí tự đặc biệt. 
{{< /notice >}}

### Chế độ trợ giúp (help mode)

REPL của Julia chia làm các chế độ khác nhau. Khi chạy lệnh như trên, bạn đang ở trong một chế độ gọi là `Julian mode`. Sau đây mình sẽ giới thiệu một mode rất hữu dụng: `Help mode`. Trong chế độ này, bạn có thể xem tài liệu hướng dẫn cho các hàm, biến hoặc module, rất giống như lệnh `help` trong Matlab. Để chuyển sang chế độ trợ giúp, bạn chỉ cần nhập kí tự `?` ở đầu dòng, câu hỏi của dòng lệnh sẽ đổi thành `help?>`. Để sử dụng trở giúp, hãy sử dụng cú pháp `help?>tên_hàm_hoặc_biến`

```julia
help?> Complex
search: Complex complex ComplexF64 ComplexF32 ComplexF16 precompile

  Complex{T<:Real} <: Number

  Complex number type with real and imaginary part of type T.

  ComplexF16, ComplexF32 and ComplexF64 are aliases for Complex{Float16},
  Complex{Float32} and Complex{Float64} respectively.
```

Trong chế độ help, bạn có thể sử dụng kết hợp tính năng tab completion ở trên. Nếu bạn gặp một kí hiệu không biết gõ như thế nào, bạn có thể copy nó vào trong REPL và dùng help mode, Julia sẽ chỉ cho bạn cách để gõ nó.
```julia
help?> π
"π" can be typed by \pi<tab>

search: π

  π
  pi

  The constant pi.

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  julia> pi
  π = 3.1415926535897...
```

### Chế độ Shell 

Chế độ shell giúp bạn gọi lệnh từ shell hệ thống một cách nhanh chóng. Chế độ shell có thể được truy cập bằng cách thêm dấu `;` ở đầu một dòng. Câu hỏi ở đầu dòng REPL sẽ chuyển thành `shell>` và chúng ta có thể gọi lệnh hệ thống.

```julia
shell> cd /tmp
/tmp

shell> ls
hugo_cache
mpd.fifo
nvimeosFJ9
```

Chế độ này rất tiện lợi khi chúng ta muốn chạy những câu lệnh đơn giản. Tuy nhiên, nếu bạn cần dùng đến những đoạn lệnh có cấu trúc phức tạp hơn với điều kiện, lặp, hay pipe, chúng ta sẽ đề cập trong một bài viết khác.

### Package manager mode

Chế độ này dùng để quản lý các gói Julia được cài trong máy bạn. Nó có thể được truy cập bằng cách thêm dấu `]` ở đầu dòng. Tuy nhiên, phần này đáng được đặt ra một bài viết riêng, do đó mình sẽ không đi vào chi tiết ở đây.

### Chế độ tìm kiếm

Khi bạn nhấn tổ hợp `Ctrl + r`, câu hỏi ở dòng lệnh sẽ chuyển thành `(reverse-i-search)':`, bạn đã vào chế độ tìm kiếm ngược (reverse search). Trong chế độ này, khi bạn gõ bất kì thứ gì, REPL sẽ tìm nó trong những câu lệnh bạn đã chạy và gợi ý câu lệnh đó. Nếu có nhiều cầu lệnh khớp với cụm từ bạn nhập, câu lệnh gần đây nhất sẽ hiện ra. Nếu bạn muốn tìm câu lệnh tiếp theo mà khớp, hãy nhấn `Ctrl + r` một lần nữa. Sau khi câu lệnh bạn muốn xuất hiện, bạn có thể nhấn `Enter` để điền câu lệnh đó vào REPL, nếu không hãy nhấn `Ctrl + c` để hủy.

```julia
# sau khi nhấn Ctrl + r và điền kí tự \cup
# bạn vẫn có thể dùng tab completion trong chế độ này
(reverse-i-search)`∪': [1, 2] ∪ 4 ∪ [5, 9]
# sau khi nhấn enter
julia> [1, 2] ∪ 4 ∪ [5, 9]
```

Ngoài ra còn có một chế độ tìm kiếm khác là forward search, có thể được truy cập bằng tổ hợp phím `Ctrl + s`. Mình không hay dùng tính năng này lắm.

## Một số phím tắt trên Julia REPL

Phím tắt | chức năng
--- | ---
`Ctrl + c` | Dừng thực thi hoặc hủy lệnh đang nhập
`Ctrl + d` | Thoát Julia (khi dòng lệnh trống)
`Ctrl + l` | Xóa màn hình
`Ctrl + r` | Chế độ tìm kiếm ngược
`Ctrl + mũi tên trái ` | Di chuyển sang trái 1 từ
`Ctrl + mũi tên phải ` | Di chuyển sang phải 1 từ
`Alt + Enter` | Xuống dòng nhưng không chạy
`?` (đầu dòng) | Chế độ trợ giúp
`;` (đầu dòng) | Chế độ shell
`]` (đầu dòng) | Chế độ quản lý gói

{{< notice note >}}
Đây chỉ là một số phím tắt mà mình cho rằng hữu dụng, không phải toàn bộ
{{< /notice >}}
## Tổng kết

Ở bài này mình đã giới thiệu sơ qua về REPL của Julia, thực chất những tính năng của REPL, các công cụ khác sẽ có gần như toàn bộ chúng. Ngoài ra, Julia còn có nhiều những tính năng nâng cao khác như tạo menu, custom key binding, custom color scheme, các bạn có thể tự tìm hiểu tại [trang tài liệu Julia](https://docs.julialang.org/en/v1/stdlib/REPL/#The-Julia-REPL-1). Bản thân mình chủ yếu dùng REPL cho những tính toán đơn giản, xem lệnh help hoặc chạy một chương trình mà được viết sẵn ở đâu đó. 

Với các bạn dùng Windows, mình đưa ra một số gợi ý về Terminal:
- Terminal của [Visual Studio Code](https://code.visualstudio.com)
- [Git bash](https://gitforwindows.org)
