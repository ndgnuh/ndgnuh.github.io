---
title: "Multiple Dispatch"
date: 2020-07-20T23:51:45+07:00
draft: true
summary: "Multiple dispatch và lý do Julia không cần class"
description: "Multiple dispatch và lý do Julia không cần class"
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
- kiểu dữ liệu
---

Chào mừng quay trở lại với series Julia Dojo. Ở bài viết trước chúng ta đã tìm hiểu về hệ thống kiểu dữ liệu trong Julia. Chúng ta cũng đã biết rằng để viết hàm thì không cần định kiểu dữ liệu. Vậy tại sao lại có những hàm hoạt động với nhiều kiểu dữ liệu khác nhau? Đó là do *multiple dispatch*. Những hàm với đầu vào không cố định kiểu dữ liệu như vậy được gọi là *generic function*.

## Multiple dispatch là gì?
Trong Julia, mỗi khi một generic function được gọi với một kiểu dữ liệu mới, bộ dịch sẽ tạo ra một "phiên bản" của function đó. Sự kết hợp của một hàm và một đầu vào có kiểu cụ thể này được gọi là một *method*. Danh sách tất cả method đi với một function sẽ được khi trong một bảng nhớ ảo trong chính function đó. Trong runtime (thời gian chạy), Julia sẽ tìm chính xác method cần gọi trong bảng trên, dựa vào những tham số đầu vào khi gọi hàm. Điều này khả thi vì khi gọi hàm, thông tin về tham số đầu vào đều sẵn có.

Cơ chế này không chỉ riêng Julia có, nhưng rất ít ngôn ngữ khác được thiết kế theo cơ chế này. Một ví dụ nhỏ với phép toán `*`:
```julia
mat_a = [1 2; 3 4]
mat_b = [2 0; 1 1]
x = 4
y = 5
mat_a * mat_b # nhân ma trận
mat_a * x # nhân ma trận với số
x * y # nhân số với số
```

Phép toán trên thực chất cũng là một hàm và có thể gọi như hàm thông thường (`*(1, 3) == 3`). Để xem tất cả methods của một hàm, ta dùng hàm `methods`.
```julia
methods(sum)
# 13 methods for generic function "sum":
# [1] sum(x::Tuple{Any,Vararg{Any,N} where N}) in Base at tuple.jl:396
# [2] sum(r::StepRangeLen) in Base at twiceprecision.jl:536
# [3] sum(r::AbstractRange{#s69} where #s69<:Real) in Base at range.jl:978
# ... Kết quả khá dài
```

## Class là không cần thiết

Bản thân tác giá lần đầu tìm hiểu Julia cũng không thấy mặn mà vì thiếu đi class, sau một thời gian sử dụng Julia mới thấy Multiple Dispatch có những ưu điểm của class, thậm chí có nhứng ưu điểm mà class không có.

### Đa hình

Điều này là hiển nhiên vì Multiple Dispatch tạo method với mỗi kiểu dữ liệu mới. Điểm khác biệt với những ngôn ngữ lập trình hướng đối tượng với class là: method trong những ngôn ngữ này gắn liền với class, trong khi method trong Julia gắn với function.

Điều này thậm chí có một vài ưu điểm so với ngôn ngữ với những ngôn ngữ với class. Thứ nhất, vì method gắn với hàm chứ không phải class, chúng ta có thể định nghĩa generic một cách dễ dàng. Thứ hai, với Multiple Dispatch, chúng ta có thể mở rộng chức năng cho một kiểu dữ liệu tùy ý mà không cần thay đổi mã nguồn của kiểu dữ liệu hay tạo ra kiểu dữ liệu mới.

Ví dụ, một thư viện cung cấp hệ màu RGB, bạn muốn một hàm chuyển đổi từ RGB sang YMCK nhưng thư viện này không cung cấp. Trong ngôn ngữ với class, bạn hoặc phải viết lại toàn bộ mã nguồn của class - Không hay cho lắm, hoặc phải kế thừa lại class RGB và viết method cho class mới đó. Nhưng chuyện kế thừa lại cũng nhiều vấn đề: class mới tên là gì, có ý nghĩa gì, thậm chí class RGB trên có thể không được cho kế thứa... Với Multiple Dispatch, bạn có thể đơn giản viết một hàm như sau:
```julia
function YMCK(color::RGB)
	# convert logic trong này
end
```
Không có class nào cần phải viết lại, không có class nào để kế thừa, chỉ cần viết hàm.

### Đóng gói

Nếu như những ngôn ngữ khác sử dụng namespace để quản lý tên thì Julia cũng có `module`. Một module bao gồm những hàm, kiểu dữ liệu, và biến số. Một số đặc điểm trong module của Julia là:
- Namespace trong những ngôn ngữ class chỉ có class bên trong, còn module có hàm, kiểu dữ liệu (struct) và biến/hằng số
- Một module có thể mở rộng hàm của module khác, ví dụ như gói `SymEngine` định nghĩa ra kiểu dữ liệu là `Basic` và phép cộng trừ nhân chia, cộng nhân ma trận trên đó. Tuy nhiên, khi thực hiện các thao tác trên chúng ta vẫn chỉ cần viết dấu `*`, `+` và `det(...)` mà không phải làm mấy trò con bò như `SymEngine.sym_mul`, `SymEngine.sym_add` hay `SymEngine.sym_matrix_det`. Lý do vì gói này đã mở rộng thêm những method cho hàm cộng và nhân trong module `Base` (module gốc của Julia). Cơ chế này không chỉ áp dụng cho toán tử mà tất cả các hàm, kể cả hàm tự định nghĩa.
- Việc gọi hàm không nhất thiết phải chỉ ra hàm đó thuộc namespace nào, lý do vì các gói Julia thường extend lại hàm của nhau và mỗi khi dùng gói, ta chỉ lấy thêm những method được định nghĩa trong module đó. Ví dụ:

### Kế thừa

Trong Julia, kiểu dữ liệu chia làm trừu tượng (`AbstractArray`, `Number`, `Real`...) và cụ thể (`Float32`, `Bool`, `Int64`...). Cơ chế kế thừa của Julia rất đơn giản: *dùng method với kiểu dữ liệu cụ thể nhất có thể*. Nói cách khác, khi ta gọi một hàm, nếu kiểu của tham số có một method cụ thể, nếu không thì Julia sẽ tìm tới method của những kiểu dữ liệu trừu tượng hơn. 

> Vẫn không hiểu?

Sau đây là một ví dụ nho nhỏ:
```julia
function square(x::Number)
	@info "square cho Number nói chung"
	x * x
end
square(2) # square cho Number
square(1 + 2im) # square cho Number
function square(x::Real)
	@info "square cho Real, Real <: Number"
	x * x
end
square(2) # square cho Real
square(1 + 2im) # square cho Number
function square(x::Float32)
	@info "square cho Float32, Float32 <: AbstractFloat <: Real"
	x * x
end
square(2f0) # square cho Float32
square(2) # square cho Real
square(1 + 2im) # square cho Number
```

Vì kiểu dữ liệu cụ thể không thể làm kiểu dữ liệu con của nhau trong Julia, chỉ có method mới có thể được kế thừa từ kiểu dữ liệu cha.

## Multiple Dispatch đặc biệt

### Dispatch với DataType

Hàm `rand` của `Julia` có một số cách gọi như sau:
```julia
rand(DataType, ...)
rand(Float32, ...)
rand(Int, ...)
rand(Distribution, ...) # từ gói Distributions.jl
```

Mỗi cách gọi sẽ trả về một số, ma trận ngẫu nhiên tùy vào kiểu dữ liệu được ở tham số thứ nhất. Dispatch như trên có thể được viết bằng cú pháp:
```julia
function f(::Type{DataTypeHere}, ...)
	# thân hàm
end
```

Ví dụ:
```julia
function f(::Type{Real}, x)
	x + 1
end
function f(::Type{Complex}, x)
	x * 2
end

f(Real, 10) # trả về 11
f(Complex, 11) # trẻ về 22
f(Float32, 1) # lỗi, không có method nào như thế này
```

Dispatch với tham số là kiểu dữ liệu không sử dụng kiểu dữ liệu con, do đó gọi `f` với `Float32` như ở trong ví dụ trên lỗi (dù `Float32` là kiểu con của `Real`). Đương nhiên, tham số dựa trên kiểu dữ liệu có thể được đặt ở bất cứ vị trí nào trong hàm, nhưng hàm trong Julia thường viết với tham số loại này ở đầu.

### Dispatch với Val

Kiểu dữ liệu Val được dùng để dispatch trên một số giá trị biết trước. Sử dụng `Val` hơi giống với `switch - case` trong C, nhưng gọn hơn rất nhiều. Cách viết dispatch với `Val` khá giống với cách viết của dispatch kiểu dữ liệu, nhưng thay vì `Type{DataType}` thì ta viết `Val{giá trị}`.
```julia
function do_something(x, ::Val{:double})
	x * 2
end
function do_something(x, ::Val{:sqrt})
	sqrt(x)
end
function do_something(x, ::Val{:add3})
	x + 3
end
```

Để gọi một hàm với giá trị như trên chúng ta phải dùng hàm `Val`:
```julia
do_something(4, Val(:double)) # 8
do_something(4, Val(:sqrt)) # 2.0
do_something(4, Val(:add3)) # 7
```

*Lưu ý*: Để viết hàm ta dùng `Val{...}` (ngoặc nhọn), để gọi hàm ta dùng `Val(...)` (ngoặc tròn).

Trong một vài trường hợp, chúng ta có thể làm một trick nho nhỏ như sau để gọi hàm tiện lợi hơn:
```
do_something(x, action::Symbol) = do_something(x, Val(action))
```

Khi đó chúng ta có thể gọi hàm với kiểu Symbol mà không cần `Val`:
```julia
do_something(4, :double) # 8
do_something(4, :sqrt) # 2.0
do_something(4, :add3) # 7
```

## Lưu ý khi extend function

Chúng ta sẽ kết thúc bài này bằng một vài lưu ý. Thứ nhất, *có thể có hai hàm cùng tên*. Nếu muốn extend một hàm từ một module của thư viện khác, tốt nhất hãy dùng: `TênModule.tên_function` khi khai báo một method mới cho một hàm có sẵn. Ngoài ra, bạn cũng có thể dùng 
```julia
Import: hàm_1, hàm_2, ...# danh sách hàm cần extend
```
trước khi định nghĩa method mới. Nếu không muốn định nghĩa method mới mà viết hàm mới thì không cần làm những việc trên, chỉ cần không `export` hàm đó ra là được (`export` là gì nói sau).

Thứ hai, khi extend một hàm từ module `Base`, những module khác cũng sẽ dùng method mới được định nghĩa đó. Ví dụ, nếu định nghĩa `*` với kiểu `Symbol` như sau:
```
module A
import Base.*
*(x::Symbol, y::Symbol) = Symbol(x,y)
end
```
Thì tất cả các module khác dùng `Base` mà dùng `*` cũng có thể dùng method trên. Vì vậy hãy cận thận kiểm tra xem method đó đã được định nghĩa chưa trước khi khai báo. 
