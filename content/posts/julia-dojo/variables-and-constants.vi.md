---
title: "Julia Dojo: vài đường cơ bản"
date: 2020-01-27T17:28:39+07:00
url: "/julia-dojo/variables-constants"
draft: false
summary: "Biến số, hằng số, kiểu dữ liệu và một số thao tác đơn giản với chúng trong Julia"
description: "Biến số, hằng số, kiểu dữ liệu và một số thao tác đơn giản với chúng trong Julia"
categories:
- hướng dẫn
- lập trình
tags:
- julia
series:
- Julia Dojo
keywords:
- julia
- lập trình
- học lập trình
- ngôn ngữ julia
- julia dojo
- julialang
- hướng dẫn
---

Chào mừng các bạn trở lại với Julia Dojo. Hôm nay chúng ta sẽ tìm hiểu về một thứ khá cơ bản và thiết yếu trong các ngôn ngữ lập trình, đó là biến số (ok, không hẳn là thiết yếu, nhưng nó làm cuộc sống dễ dàng hơn).

{{< notice info >}}
Đôi khi, trông các bài hướng dẫn về ngôn ngữ lập trình, họ đồng nhất biến số và hằng số theo kiểu "hằng số là một biến số mà không thể thay đổi". Điều này không đúng lắm về mặt kĩ thuật (technically correct is the best kind of correct). Tuy nhiên, nếu nó tiện lợi, nghe thuận tai và dễ hiểu hơn với bạn thì... meh, tùy, whatever floats your boat.
{{< /notice >}}

## Biến số, hằng số

Để khai báo một biến trong Julia, bạn chỉ cần sử dụng cú pháp:

```julia
tên_biến = "giá trị"
こんにちは世界 = "Hello world, google dịch vậy :)"
```

Điều hay nhất là: hai dòng lệnh trên hoàn toàn hợp lệ trong Julia (copy nó vào REPL và chạy thử đi!). Tên biến số, hằng số trong Julia có thể Là kí tự unicode, và các kí tự tiếng Việt không phải ngoại lệ. Tuy nhiên, mình nghĩ bạn không nên code bằng tiếng Việt có dấu, tiêng Nhật, tiếng Tàu hay tiếng Thái đâu. Cách tốt nhất để dùng tính năng này là:

```julia
#=
Bạn có thể gõ cái này theo các bước:
1. Nhập "\varepsilon" (var epsilon)
2. Nhấn phím <tab>              
Tính năng này có trên mọi công cụ hỗ trợ Julia
=#
ε = 1e-9 # Giờ thì công thức toán trong
         # code của bạn sẽ gọn và dễ đọc hơn
```

Cực kì tiện lợi khi bạn code những phần mềm dùng nhiều công thức toán (mà lúc nào chẳng có toán chứ?). Nhân tiện mình giới thiệu luôn, dấu `#` được dùng để comment trên một dòng code (tất cả những gì sau dấu này sẽ được bỏ qua; còn cặp dấu `#=` và `=#` được dùng để comment trên nhiều dòng, mọi thứ giữa hai thằng này sẽ bị bỏ qua khi chạy code.

Còn đề khai báo hằng số, bạn chỉ cần nhét thêm chữ `const` vào đầu dòng như sau:
```julia
const hằng_số = true
```

Bất kì biến số, hằng nào bạn định nghĩa như trên trong REPL đều được coi là biến toàn cục. Nếu bạn viết một phần mềm sản xuất, hãy dùng ít biến toàn cục nhất có thể (vì lí do hiệu năng, lí do bảo dưỡng, v.v... bạn không dùng càng tốt). Nhưng hằng số toàn cục vẫn ok nhé, thực chất Julia chỉ cho phép khai báo hằng số toàn cục thôi. Bạn có thể dùng từ khóa `local` để khai báo nội bộ và từ khóa `global` để khai báo toàn cục.

```julia
local x = 1 
global y = 2
local const z = "lỗi"
```

Nếu bạn khai báo biến `local` trưc tiếp trên REPL, nó sẽ biến mất ngay lập tức và bạn không dùng được nó. Vậy biến nội bộ có hiệu lực ở đâu, hồi sau sẽ rõ :) Giờ chúng ta chuyển sang nói qua về kiểu dữ liệu.

## Kiểu dữ liệu

Khi bạn gán một biến trong Julia, bộ dịch sẽ tự phát hiện kiểu và gắn kiểu dữ liệu của nó cho biến. Điều tương tự cũng xảy ra với hằng số. Bạn có thể lấy kiểu dữ liệu của một biến hay hằng bằng hàm `typeof`:

```julia
x = 1.0
typeof(x) # Trả về một kiểu Float
typeof(π) # Trả về Irrational{:π}
          # đây là một hằng số
          # viết bằng cách \pi <tab>
          # có thể dùng chữ pi cũng được
```

Nhìn mấy cái kiểu dữ liệu có vẻ lằng nhằng, nhưng chúng ta đang ở [Level 1](/julia-dojo), đừng bận tâm về nó vội. Mình chỉ giới thiệu qua một số kiểu dữ liệu hay dùng ở đây thôi.

### Các kiểu số

Một ít int
```julia
n = 3
```

Một ít float
```julia
x = 2.0 
y = 4.0
```

Một ít hữu tỉ
```julia
p = 1//2
```

Một ít hư ảo
```julia
z = 1 + 2im # hoặc 1 + 2 * im
```

Một ít phép toán
```julia
đối = -z
cộng = n + x
trừ = n - z
nhân = z * p
chia = n / x # lấy n chia x
chia_ngược = n \ x # lấy x chia cho n
chia_hữu_tỉ = z // (3 - 4im)
lũy_thừa = x^n
lấy_căn = sqrt(4)
lấy_căn_phức = sqrt(complex(-1)) # sqrt(-1) sẽ lỗi, vì kiểu của -1 là Real
giá_trị_tuyệt_đối = abs(-3.4)
module_phức = abs(z)
```

Một ít hàm toán học
```julia
# Các hàm liên quan đến logarith
exp(x) # e^x, e là hằng số Euler
log(x) # loga cơ số e
log10(x) # loga cơ số 10
log2(x) # loga cơ số 2
log1p(x) # loga cơ số e của (1 + x)
log(y, x) # loga cơ số y của x
# Các hàm liên quan tới lượng giác
# Ngoài sin ra còn có cos, tan, cot
sin(x) # lượng giác, dùng radian, tương tự có cos, tan, cot
sind(x) # như sin, nhưng dùng đơn vị độ
sinh(x) # hàm hyperbolic
asin(x) # lượng giác ngược
asind(x) # như asin, đơn vị độ
asinh(x) # hàm hyperbolic ngược
deg2rad(x) # chuyển từ độ sang radian
rad2deg(x) # chuyển từ radian sang độ
```

Một ít phép so sánh
```julia
bé_hơn = (x < y)
lớn_hơn = (x > y)
bằng = (x == y)
khác = (x != y)
khác = (x ≠ y) # \ne<tab>
xấp_xỉ = isapprox(x, y)
xấp_xỉ = (x ≈ y) # \approx<tab>
không_xấp_xỉ = (x ≉ y) # \napprox<tab>
lớn_hơn_hoặc_bằng = x >= y
lớn_hơn_hoặc_bằng = x ≥ y # \ge<tab> (Greater than or Equal)
bé_hơn_hoặc_bằng = x <= y
bé_hơn_hoặc_bằng = x ≤ y # \le<tab> (Less than or Equal)
```

### Kiểu Bool

Julia dùng `true` và `false` cho các giá trị thuộc kiểu `Bool`
```julia
a = true
b = false
phủ_định = !a
và_logic = a && b
hoặc_logic = a || b
xor_logic = xor(a, b)
xor_logc = a ⊻ b # \xor<tab>
```

### Kí tự và xâu kí tự

Trong Julia, kí tự được bao quanh bởi dấu nháy đơn, còn xâu kí tự được bao quanh bởi dấu nháy kép. Bạn có thể dùng 3 dấu nháy kép để viết các xâu kí tự phức tạp, gồm nhiều dòng.
```julia
kí_tự = 'a'
xâu = "hello world"
xâu_phức_tạp = """
    "Trăm năm trong cõi người ta,
    Thúy Kiều là mẹ, con là Thúy Vân"
    
    Câu thơ cho thấy thằng nào ngồi viết cái này rất dốt văn...
"""
```

Julia hỗ trợ "nội suy" xâu kí tự (string interpolation, không mình biết dịch đúng không nữa). Dùng dấu `$` là bạn có thể "nhúng" một biến vào trong xâu kí tự. Nếu bạn muốn dưa một biểu thức vào, hãy dùng `$(biểu_thức)`.
```julia
x = rand(-3:3)
println("một số ngẫu nhiên trong khoảng -3 tới 3: $x")
# hoặc
println("một số ngẫu nhiên trong khoảng -3 tới 3: $(rand(-3:3))")
```

Một số hành động với kí tự và xâu kí tự:
```julia
clipboard("copy toàn bộ xâu kí tự này, dùng cái này max tiện")
collect("xâu kí tự") # chuyển xâu kí tự thành một mảng các kí tự
Int('c') # Chuyển kí tự sang mã Unicode
Char(97) # Chuyển mã kí tự thành kí tự
"nối" * "xâu" * "kí tự"
"nhân lên 3 lần " ^ 3
"abc" < "abd" # so sánh theo thứ tự từ điển, dựa vào mã kí tự
```

### Mảng, ma trận

Phần hay nhất để dành cuối cùng :) Julia hộ trợ tính toán ma trận **rất ngon**. Ngon thế nào thì từ từ mới biết hết, đặc biệt các bạn dùng Matlab có thể sẽ thấy nó quen thuộc. Phần này đáng có một bài viết riêng, vì vậy trong bài này mình chỉ giới thiệu thôi.

Trong Julia, số chiều của ma trận được phân biệt rất rõ ràng. Khi khai báo một vector, chúng ta dùng dấu `,` hoặc `;` để ngăn cách các phần tử:
```julia
A = [1, 2, 3]
B = rand(3) # vector ngẫu nhiên
```

Đoạn code trên sẽ tạo ra `A` và `B` là vector *cột*. Đối với ma trận, chúng ta dùng dấu cách ngăn cách các phần tử cùng hàng, và dấu `;` để ngăn cách giữa các dòng
```julia
M = [1, 2, 3; 4, 5, 6; 7, 8, 9] # lỗi, không dùng được dấu "," đâu
M = [1 2 3; 4 5 6; 7 8 9]
N = rand(3, 3) # ma trận ngẫu nhiên
```

Để lấy chỉ số của vector, ma trận, chúng ta dùng cú pháp `ma_trận[chỉ_số]`. Julia lưu ma trận theo cột, chúng ta có thể dùng chỉ số 1 chiều hoặc 2 chiều để lấy ra phần tử của ma trận.
```julia
M[2, 3] # hàng 2 cột 3, trả ra 6
M[4] # phần tử thứ 4, nhưng duyệt theo từng hàng, trả ra 2
M[end] # phân tử cuối cùng
M[1:2, end] # hàng 1 tới hàng 2, cột cuối cùng
M[end, [1, 3]] # cột 1 và 3, hàng cuối cùng
M[[1, 2], [2, 3]] # đoán xem? :)
M[:, end] # cột cuối
```

Trong Julia, việc gán ma trận sẽ không tạo bản copy của ma trận đó, trừ khi bạn lấy một phần của ma trận:
```julia
L = M
L[1] = 2 # M cũng bị thay đổi
L = M[[1, 2], :]
L[1] = 3 # M không bị đổi
L = copy(M) # copy lại M, tạo ma trận mới
L[1] = 3 # M không bị đổi
```

Các phép toán với vector, ma trận được thực hiện rất tự nhiên (theo quy tắc toán học):
```julia
A * B # báo lỗi, hai vector có chiều 1 × 3 không nhân với nhau được
A * B' # nhưng nếu B chuyển vị thành vector hàng thì ok :)
M * N # hai ma trận (3, 3) nhân với nhau
M * A # nhân ma trận (3, 3) với vector (3, 1)
A + B # cộng vector
M + N # cộng ma trận
A + B' # lỗi, cộng vector ma trận phải cùng chiều
A .+ B' # nhưng cộng từng phần tử lại là chuyện khác :)
A .* B' # nhân phần tử cũng vậy luôn
M ^ 5 # ma trận vuông có thể lấy lũy thừa
M .^ 5 # lũy thừa từng phần tử
```

{{< notice info >}}
Lưu ý rằng, đối với trường hợp số thực, chúng ta có thể dùng `A'` để chuyển vị. Với ma trận số phức hãy dùng `transpose`. Để biết chi tiết hãy xem thêm:
- transpose: https://en.wikipedia.org/wiki/Transpose
- adjoint (dấu nháy): https://en.wikipedia.org/wiki/Conjugate_transpose

(sorry vì màu link khó nhìn, mình sẽ gửi issue lên người bảo trì theme này) 
{{< /notice >}}

## Kết luận

Ok, phần giới thiệu tới đây mình nghĩ đủ rồi. Vậy các là các bạn đã biết  cách khai báo biến, cộng trừ nhân chia và những trò hay ho mà trên trường giáo viên sẽ bắt chúng ta ngồi tính sấp mặt. Giờ bạn có thể dùng Julia như một cái máy tính cá nhân (nhưng vạn năng hơn một tí). Hẹn gặp các bạn trong bài viết sau.
