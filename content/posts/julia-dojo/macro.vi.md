---
title: "Julia dojo: Macro & meta programming"
date: 2020-08-21T09:53:03+07:00
draft: true
summary: "Macro và meta programming trong Julia"
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
- macro
- meta
- meta programming
---

Trong khi lập trình, để rút ngắn và làm mã nguồn trong sạch, dễ đọc hơn, chúng ta thường viết các hàm với những chức răng riêng biệt. Tuy nhiên, đôi lúc viết hàm không phải là đủ. Khai báo hàm có thể cồng kềnh, bị lồng vào nhau, những cấu trúc lặp đi lặp lại nhưng không dùng hàm xử lý được... Những trường hợp đó là nơi macro tỏa sáng. May thay, những nhà khoa học MIT đã lường trước điều này và thiết kế Julia với một hệ thống macro - meta programming đầy đủ chức năng.

## Sử dụng Macro

Macro được tận dụng khá nhiều trong Julia. Chúng thường được nhận biết bằng dấu `@` ở đầu. Một số macro quen thuộc là:
- `@time`: đo độ trễ khi chạy một biểu thức
- `@show`: hiện giá trị một biến
- `@info`: hiện một thông báo với chữ màu
- `@error`: quăng một lỗi, *không* dừng chương trình
- `@warning`: quăng một cảnh báo, *không* dừng chương trình
- `@.`: broadcast mọi hàm trong scope

Khi dùng macro, chúng ta đặt macro trước biểu thức cần tác động vào. Macro sẽ có hiệu lực trong biểu thức đứng trước nó. Ví dụ:
```julia
x = [1, 2, 3]
@. sum(x^2) #  [1, 4, 9]
sum(@. x^2) # 14
@. x^2, x^3 # ([1, 4, 9], [1, 8, 27])
```

Ngoài ra, chúng ta còn có macro với đuôi `_str`. Đây là những macro được thiết kế đặc biệt cho kiểu dữ liệu String, và có cách gọi rút gọn:
```julia
using Markdown
@md_str "**Bold**"
md"**Bold**"
@html_str "<b>Bold</b>"
str"<b>Bold</b>"
```

Để xem macro sẽ tạo ra đoạn code như nào, ta dùng macro `@macroexpand`:
```julia
@macroexpand @. sum(x^2)
# trả về :(sum.((^).(x, 2)))
@macroexpand sum(@. x^2)
# trả về :(sum((^).(x, 2)))
```

Từ ví dụ trên có thể thấy `@. sum(...)` tác động tới cả hàm `sum` vì `sum` nằm trong biểu thức mà nó tác động vào, còn `sum(@. ...)` thì không.

## Tự tạo macro

### Kiểu dữ liệu Expr
Khi một đoạn mã Julia được dịch, trước hết nó được đưa qua *Abstract Syntax Tree* (AST). Kiểu dữ liệu `Expr` biểu diễn đoạn mã julia khi được đưa qua AST. Một `Expr` gồm hai phần là `head` và `args`. Trong đó `head` là phần cho biết đoạn mã nguồn thuộc loại biểu thức gì (gọi hàm, lặp, rẽ nhánh...); `args` là một vector chứa những biểu thức con.

```julia
expr = :(1 + (2 + 3))
dump(expr)
# Expr
#   head: 
# Symbol call
#   args: Array{Any}((3,))
#     1: Symbol +
#     2: Int64 1
#     3: Expr
#       head: Symbol call
#       args: Array{Any}((3,))
#         1: Symbol +
#         2: Int64 2
#         3: Int64 3
```

Hàm `dump` in ra một cách trực quan cấu trúc của `Expr`. Để tạo ra một `Expr`, nếu biểu thức ngắn, chúng ta có thể bọc `:(...)` quanh biểu thức.
```
ex = :(sum(c))
ex.head # :call
ex.args
# 2-element Array{Any,1}:
#  :sum
#  :c
```

Hoặc dùng khối `quote` với một nhóm biểu thức hoặc một biểu thức dài:
```
ex = quote
	a = 1
	b = 2
	a + b
end
ex.head # :block
ex.args
# 6-element Array{Any,1}:
#  :(#= REPL[96]:2 =#)
#  :(a = 1)
#  :(#= REPL[96]:3 =#)
#  :(b = 2)
#  :(#= REPL[96]:4 =#)
#  :(a + b)
```

Gọi `Meta.parse` để chuyển một đoạn code về AST:
```julia
expr = Meta.parse("1 + 1")
dump(expr)
# Expr
#   head: Symbol call
#   args: Array{Any}((3,))
#     1: Symbol +
#     2: Int64 1
#     3: Int64 1
```

Cách cuối cùng là gọi trực tiếp `Expr` với tham số là các biểu thức:
```julia
ex = Expr(:call, :(+), 1, 1)
# :(1 + 1)
```

Mặc dù nhìn như lời gọi hàm như tất cả mọi thứ chỉ là biểu thức, do đó nếu có một biến số, hàm bên trong `Expr` thì nó không cần được xác định cho tới khi `Expr` được đánh giá. Để đánh giá một biểu thức ở dạng `Expr`, chúng ta dùng hàm `eval`.
```julia
ex = :(sum(c)) # không gây lỗi, vì :c chỉ là một biểu thức con
eval(ex) # gây lỗi vì `c` chưa được định nghĩa
c = [1,2,3]
eval(ex) # trả về 6
```

Nếu muốn đưa một biến có sẵn vào trong `Expr`ession, chúng ta dùng cú pháp nội suy giống trong xâu kí tự:
```julia
x = π
expr = :(1 + $x)
dump(expr)
# Expr
#   head: Symbol call
#   args: Array{Any}((3,))
#     1: Symbol +
#     2: Int64 1
#     3: Irrational{:π} π
```

Có thể nói, bản thân mã nguồn cũng chỉ là một kiểu dữ liệu trong Julia. Do đó việc meta-programming trong Julia diễn ra rất tự nhiên.

### Cách viết macro

Cú pháp của macro khá giống hàm
```julia
macro tên_macro(expr)
	# thân macro
end
```

Cách hoạt động của macro có thể được hiểu như sau:
1. Macro nhận biểu thức cần tác động qua tham số đầu tiên của nó dưới kiểu dữ liệu `Expr`
2. Phần thân macro biến đổi biểu thức, trả về một `Expr` khác
3. Julia lấy biểu thức `Expr` do macro trả về và đánh giá nó

Chúng ta có thể "thử" thông qua macro sau
```julia
macro m1(ex)
	@show typeof(ex)
	@show ex
	return ex
end

@m1 1 + 1
# typeof(ex) = Expr
# ex = :(1 + 1)
# 2

@m1 1 + 1, 2 * 2
# typeof(ex) = Expr
# ex = :((1 + 1, 2 * 2))
# (2, 4)
```

Có thể thấy, macro `@show` đã được gọi trong phần thân của `m1`, kết quả trả về của `@m1` là một biểu thức và được đánh giá ngay lập tức. Dưới đây là một macro mà tìm nghịch đảo của một biểu thức:
```julia
macro inv(ex)
	Expr(:call, :(/), 1, ex)
end
@inv 4 # 0.25
@inv 5 # 0.2
```

Thực ra, macro cũng có thể nhận nhiều tham số, tham số của macro được ngăn cách bằng dấu `,`, sẽ phải dùng ngoặc (trước ngoặc không có dấu cách), hoặc dùng dấu cách:
```julia
macro inv2(ex, i = 1)
	Expr(:call, :(/), i, ex)
end
@inv2 4 # 0.25
@inv2(5, 2) # 0.4
@inv2 5 2 # 0.4
```

Dưới đây là một phiên bản khác của macro dùng `quote`.
```julia
macro inv(ex)
	quote
		1 / $(ex)
	end
end
```
phần expression được bọc trong cú pháp nội suy `$(...)`.

### Macro hygiene
Macro trong những ví dụ trên chạy rất bình thường. Giả sử chúng ta đang viết một phần mềm, chúng ta muốn chia module, và có một module như sau

```julia
module MyMacro

"""
	@inv expr

Nghịch đảo biểu thức
"""
macro inv(ex)
	quote
		1 / $(ex)
	end
end

# end of module
end
```

Sau khi chạy đoạn mã nguồn module trên, chúng ta nhập macro đó để sử dụng:
```julia
using Main.MacroExample: @inv
```

Nhưng đoạn mã nguồn sau sẽ gây lỗi:
```julia
x = 4
@inv x
# ERROR: UndefVarError: x not defined
# Stacktrace:
#  [1] top-level scope at REPL[1]:...
```

Nhưng `x` đã được định nghĩa, vậy chuyện gì đã xảy ra? Macro trên được gọi là "vệ sinh" (hygiene), tức là nó chỉ dùng những biến trong phạm vi mà macro đã được định nghĩa (trong module). Trong trường hợp này `MacroExample.@inv` sẽ gọi tới `MacroExample.x` (không tồn tại), dẫn đến lỗi như trên.

Giờ biến `x` cần được trỏ tới `x` trong môi trường gọi macro. Chúng ta có thể giải quyết vấn đề này bằng cách `esc` (escape) nó. Macro `@inv` sẽ được định nghĩa như sau:
```julia
macro inv(ex)
	quote
		1 / $(esc(ex))
	end
end
```

Nói cách khác, macro này dùng biến trong môi trường gọi macro, tức là nó "không vệ sinh" (unhygiene). Một phiên bản gọn hơn của `@inv`
```
macro inv(ex)
	Expr(:call, :(/), 1, esc(ex))
end
```

Vậy chuyện gì sẽ sảy ra nếu trong môi trường khai báo có một biến trùng tên với biến nội bộ của macro?
```julia
macro inv3(ex)
	x = 1
	Expr(:call, :(/), x, esc(ex))
end

x = 4
@inv3 x # 0.25
```

Câu trả lời là không có gì xảy ra, macro vẫn hoạt động bình thường, vì hàm `gensym` của Julia tạo ra một biểu tượng độc nhất cho mỗi biến nội bộ của macro.

### Macro & multiple dispatch

Vì macro giống function nên cũng có các method khác nhau, vẫn là ví dụ `inv`:
```julia
macro inv(ex)
	Expr(:call, :(/), x, esc(ex))
end
macro inv(ex...)
	quote
		map($(esc(ex))) do x
			1 / x
		end
	end
end
@inv 1 2 4 5 # (1.0, 0.5, 0.25, 0.2)
```

### Macro với cách gọi tắt cho string

Những macro có tên với đuôi `_str` sẽ *tự động* có cách gọi tắt với String.
```julia
macro capslock_party_str(s)
	quote
		uppercase($(esc(s)))
	end
end

capslock_party"wooloowooloo" # "WOOLOOWOOLOO"
```
Đương nhiên ta vẫn có thể gọi theo cách thông thường:
```julia
s = "wooloowooloo"
@capslock_party_str s  # "WOOLOOWOOLOO"
```

## Khi nào dùng macro

Trường hợp thường thấy khi dùng macro là macro cho string (`@..._str`), trường hợp thường thấy tiếp theo là chúng ta có một cấu trúc code lặp đi lặp lại, nhưng lại là cấu trúc không thể dùng hàm để mô tả được. Khi đó macro sẽ giảm thiểu tối đa việc trùng lặp. Giả sử chúng ta đang cần một kiểu dữ liệu biểu diễn tổng của các số mà không làm mất đi thông tin các số hạng.

```julia
struct Summation{T<:Real} <: Real
	terms::AbstractArray{T}
	Summation(xs...) = Summation(collect(xs))
	Summation(xs::AbstractArray) = new{eltype(xs)}(vec(xs))
end
```

Giờ chúng ta muốn định nghĩa lại các hàm sơ cấp lượng giác trên kiểu dữ liệu này. Nếu không dùng macro chúng ta sẽ dùng như sau:
```julia
Base.sum(s::Summation) = sum(s.terms)
Base.length(s::Summation) = length(s.terms)
Base.sin(s::Summation) = sin(sum(s))
Base.cos(s::Summation) = cos(sum(s))
Base.tan(s::Summation) = tan(sum(s))
Base.cot(s::Summation) = tan(sum(s))
Base.asin(s::Summation) = asin(sum(s))
Base.acos(s::Summation) = acos(sum(s))
Base.atan(s::Summation) = atan(sum(s))
Base.acot(s::Summation) = acot(sum(s))
# sinh, cosh, tanh, cosh, asinh, acosh....
```

Nói chung là dài. Với macro, chúng ta có thể làm như sau (hãy mở lại Julia và định nghĩa lại struct trên trước khi thử)
```julia
for op in (:sin, :cos, :tan, :cot),
	 vop in Symbol.([op, "a$(op)", "$(op)h", "a$(op)h"])
	@eval Base.$vop(s::Summation) = $vop(sum(s))
end
```

Trong đó `@evals x` là macro cho `eval(:(x))`. Giờ thử với `methodswith`:
```julia
methodswith(Summation)
# [1] acos(s::Summation) in Main at REPL[2]:2
# [2] acosh(s::Summation) in Main at REPL[2]:2
# [3] acot(s::Summation) in Main at REPL[2]:2
# [4] acoth(s::Summation) in Main at REPL[2]:2
# [5] asin(s::Summation) in Main at REPL[2]:2
# [6] asinh(s::Summation) in Main at REPL[2]:2
# [7] atan(s::Summation) in Main at REPL[2]:2
# [8] atanh(s::Summation) in Main at REPL[2]:2
# [9] cos(s::Summation) in Main at REPL[2]:2
# [10] cosh(s::Summation) in Main at REPL[2]:2
# [11] cot(s::Summation) in Main at REPL[2]:2
# [12] coth(s::Summation) in Main at REPL[2]:2
# [13] sin(s::Summation) in Main at REPL[2]:2
# [14] sinh(s::Summation) in Main at REPL[2]:2
# [15] tan(s::Summation) in Main at REPL[2]:2
# [16] tanh(s::Summation) in Main at REPL[2]:2
```

Như vậy chúng ta với 4 dòng gọn gàng chúng ta đã định nghĩa được 16 method cho kiểu dữ liệu này mà không có dòng nào bị trùng lặp hay thừa.

## Những macro hữu dụng

Đây không phải tất cả macro, trong các module khác có thể có nhiều macro hơn nữa. Macro khá ít so với hàm nên có thể được tìm nhanh bằng cách gõ `@` và tab trên REPL.

Macro                        | chức năng
---                          | ---
@time                        | tính thời gian thực thi
@btime (từ Benchmark.jl)     | tính thời gian thực thi, nhưng chính xác hơn và không bao gồm thời gian JIT
@benchmark (từ Benchmark.jl) | đánh giá biểu thức, bao gồm thống kê thời gian thực thi và phân bố bộ nhớ
@.                           | thực hiện broadcast (`f.(x)`) trên tất cả các phép toán và hàm trong cùng phạm vi
@simd                        | thực hiện simd cho vòng lặp, map và filter
@inbounds                    | không kiểm tra chỉ số khi truy cập mảng, tăng tốc đáng kể trong trường hợp kiểm soát được chỉ số mảng
@show,@info,@error           | các macro hỗ trợ debug
Base.@kwdef                  | định nghĩa struct với method khởi tạo dùng keyword
@isdefined                   | kiểm tra xem một biến được định nghĩa hay chưa
@deprecate                   | cảnh báo rằng một hàm, đoạn mã nguồn đã bị lỗi thời, không nên dùng
@view/@views                 | tạo View khi lấy chỉ số của Array thay vì tạo ra một array mới
@inline/@noinline            | báo với compiler rằng một hàm có nên được inline hay không
@__DIR__                     | đường dẫn thư mục chứa file mà macro này được gọi
@__FILE__                    | đường dẫn file chứa lời gọi macro
@__MODULE__                  | module mà code đang được gọi từ
@which                       | xem một method, hàm, biến nằm trong module nào

## Kết

Macro có vẻ là một thức khá thần thánh và hữu dụng trong nhiều trường hợp. Tuy nhiên macro không nên bị làm dụng, đa số các tình huống có thể xử lý được (một cách đủ tốt) bằng hàm và có thể kết hợp với những macro có sẵn. Dùng macro bừa bãi có thể khiến chương trình thiếu ổn định (vì macro sinh mã nguồn nên khó kiểm soát), và một số trường hợp gây ảnh hưởng tới hiệu năng.
