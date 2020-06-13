---
title: "Julia dojo: nói thêm về kiểu dữ liệu"
date: 2020-06-14T23:00:00+07:00
draft: false
summary: "Nói thêm về hệ thống kiểu dữ liệu trong Julia"
description: "Nói thêm về hệ thống kiểu dữ liệu trong Julia"
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

Chào mừng trở lại với Julia Dojo, đã khá lâu rồi không đăng bài có bài đăng với lý do deadline ngập mồm :( Bài viết trước đã giới thiệu một số kiểu dữ liệu cơ bản như số, từ điển, mảng. Trong bài viết này chúng ta sẽ khám phá một các tổng quan hơn về hệ thống kiểu dữ liệu của Julia.

## Động, nhưng không hẳn

Mặc dù Julia có hệ thống kiểu dữ liệu, Julia vẫn có những lợi thế của hệ thống kiểu tĩnh bằng khả năng định kiểu dữ liệu cho các giá trị. Lợi thế tuyệt vời nhất là: hệ thống kiểu này cho phép *dispatch* dựa trên kiểu dữ liệu trong bất kì hàm nào.

Mình không biết dịch dispatch là gì, bạn hiểu nôm na rằng, khi code chạy và hàm được gọi, kiểu dữ liệu của các tham số đều sẽ được biết hết, do đó Julia có thể tạo ra một phương thức phù hợp cho kiểu dữ liệu đó, compile nó thành mã máy và chạy. Điều này xảy ra với mọi hàm, bất kể bạn gọi nó ở đâu, do đó, bạn có thể *viết hàm mà không cần định kiểu* nhưng *code vẫn có thể chặt chẽ và nhanh*.

Ví dụ như hàm `map`, hàm này nhận vào 1 hàm `f`, một mảng `xs` (không hẳn là mảng, nhưng phần đó sẽ được nói sau), trả về một mảng khác với các phần tử của nó là `f(x)` với `x` thuộc `xs`. Đoạn code dưới đây sẽ chạy ngon lành mặc dù hàm `x -> x * ...` không có định kiểu.
```julia
map(x -> x * 1, [1,2,3])
map(x -> x * "!", ["a", "b", "c"])
```

## Định kiểu cho một giá trị

Mặc dù tôi nói ở trên bạn có thể viết hàm mà không cần định kiểu, nhưng đôi lúc bạn sẽ cần phải làm chuyện ấy. Một số lý do chúng ta sẽ muốn định kiểu:
- Đưa ra quy tắc, giúp phần mềm của chúng ta sẽ chạy như mong muốn
- Đưa thêm thông tin cho bộ dịch, có thể cải thiện hiệu năng trong một số trường hợp (nói sau)

Vậy chúng ta làm thế nào để gắn một kiểu dữ liệu vào giá trị? Chúng ta sẽ dùng phép toán `::` ("phát âm": *là một thực thể thuộc ...*). Cú pháp:
```julia
# môt điều tôi thích ở Julia là:
# dòng code này hoàn toàn legit :)
giá_trị::KiểuDữLiệu
100::Int
100.0::AbstractFloat
```

Bạn có thể định kiểu cho các biến địa phương. Khi khai báo kiểu cho biến địa phương, mọi giá trị sẽ được ép kiểu với hàm convert trước khi gán vào biến:
```julia
function()
    local n::Int8 = 2
    n = 10 # ok
    n = 255 # lỗi vì Int8 không biểu diễn được
end
```

Ngoài ra, bạn cũng có thể định kiểu cho tham số và giá trị trả về của hàm. Tham số sẽ được ép kiểu trước khi chạy và đầu ra sẽ được ép kiểu sau khi trả về (nếu được):
```julia
f(x::Integer) = x + 1 # ép kiểu tham số x thành Int
f(n)::Float32 = sin(n) # ép kiểu đầu ra thành Float32
```

## Kiểu trừu tượng (AbstractType)
Trong ví dụ ở trên một kiểu là `AbstractFloat`, đó chính là một hình ảnh về kiểu trừu tượng (phân biệt với *kiểu dữ liệu trừu tượng* nhé).

Để hiểu về kiểu trừu tượng trong Julia, hãy tưởng tượng một đồ thị có hướng, mỗi nút là một kiểu dữ liệu, và `A` → `B` có nghĩa rằng: kiểu `B` kế thừa mọi *hành động* từ kiểu `A`.

Kiểu trừu tượng trong Julia đóng vai trò là một nút phụ trong cái đồ thị trên. Ta có thể gọi một kiểu dữ liệu là *kiểu dữ liệu con* (subdatatype) của kiểu dữ liệu `A` nếu nó kế thừa những hành động của `A`. Một kiểu trừu tượng được định nghĩa bằng cú pháp:
```julia
abstract type KiểuA end
```

Một số ví dụ về kiểu trừu tượng trong Julia là `Real`, `Number`, `Integer` và `AbstractArray`. Bạn có thể kiểm tra một kiểu cụ thể có thuộc một kiểu trừu tượng không bằng phép toán `<:` hoặc `>:`.
```julia
Int <: Integer # true
Real >: Float64 # true
```

Trong Julia, kiểu dữ liệu trừu tượng cũng có thể đóng vai trò là kiểu con. Mọi kiểu dữ liệu trong Julia là kiểu con của một kiểu trừu tượng là `Any`. Hãy chạy thử ví dụ dưới đây:
```julia
Real <: Number
Number <: Any
Real <: Any
abstract type KiểuB <: KiểuA end
```

Lưu ý rằng không phải kiểu dữ liệu nào cũng so sánh được, khi đó phép so sánh sẽ mặc định trả về `false`:
```julia
Real <: Complex
Complex <: Real
```

## Kiểu dữ liệu có tham số

Trong Julia, đôi lúc chúng ta thấy những kiểu dữ liệu như sau:
```julia
julia> typeof([1,2,3])
Array{Int64,1}

julia> typeof(1+2im)
Complex{Int64}

julia> typeof(1+2.0im)
Complex{Float64}
```

Những kiểu dữ liệu như trên gọi là *kiểu dữ liệu có tham số* (hay *parametric type*). Phần ở trong cặp dấu `{}`. Trong trường hợp `Array`, tham số thứ nhất cho biết `Array` đó chứa kiểu dữ liệu thuộc loại gì, tham số thứ hai cho biết số chiều của Array đó. Trong trường hợp `Complex`, tham số cho biết phần thực và phần ảo của số phức thuộc loại gì.

Khi so sánh kiểu có tham số, cần lưu ý rằng tham số không được đưa vào so sánh, ví dụ:
```julia
Array{Int} <: Array{Number} # false
```

## Tạo một kiểu dữ liệu mới

Julia hỗ trợ tạo kiểu dữ liệu mới thông qua cú pháp `struct` hoặc `abstract type`. Cú pháp `abstract type` tạo một kiểu trừu tượng, vậy còn `struct` thì sao?
```julia
struct MyDataStruct
	prop1
	prop2::Real
end
```

Cú pháp `struct` như trên tạo ra một kiểu dữ liệu cụ thể. Cú pháp `struct` cũng hỗ trợ tham số kiểu:
```julia
struct MyDataStruct{T, N}
	prop1::Array{T, N}
	prop2::{T}
end
```

Với `struct` chúng ta có thể định ra một hàm với cùng tên để khởi tạo ra một thực thể của kiểu đó:
```julia
struct MyDataStruct{T}
	prop1::Matrix{T}
	prop2::T
	function MyDataStruct(x)
		T = typeof(x)
		arr = rand(T, 3, 3)
		new{T}(arr, x)
	end
end
```
Với ví dụ trên ta có thể gọi ra `MyDataStruct(3)` và chúng ta sẽ có `MyDataStruct` với thuộc tính đầu tiên là một ma trận ngẫu nhiên có kiểu `Int` và thuộc tính số hai là `3`. Hàm `new` là một hàm đặc biệt để tạo ra một thực thể mới. Trong trường hợp `struct` có tham số, `new` cần được gọi với các tham số kiểu (như ví dụ trên là `new{T}`). 

Mặc định, kiểu dữ kiệu định nghĩa với `struct` trong Julia không thay đổi được (nguyên văn là *immutable*, dịch hơi khó). Điều đó nghĩa rằng một khi ta gọi `x = MyDataStruct(3)` thì các thuộc tính của `x` không thay đổi được. Để định nghĩa nghĩa ra một kiểu dữ liệu mà có thay đổi được, ta cần dùng thêm từ khóa `mutable`
```julia
mutable struct MyMutableDataStruct
	val
end
```
Sau khi tạo `x = MyMutableDataStruct(3)`, chúng ta có thể đổi thuộc tính `val` bằng cách `x.val = 10`.

Ngoài ra, kiểu dữ liệu có thể được định nghĩa là kiểu dữ liệu con của một kiểu trừu tượng như sau:
```julia
abstract type MyAbstractType end
struct MyType <: MyAbstractType end
```

Cuối cùng, bạn có thể đưa một tham số vào một kiểu dữ liệu cụ thể để tạo ra kiểu dữ liệu mới.
```julia
ComplexFloat = Complex{Float64}
```

## Kết
Bài này nói về khá nhiều thứ. Một số điểm quan trọng là:
- Trong Julia có kiểu dữ liệu con mà kế thừa hành động của kiểu dữ liệu cha (super type) của nó
- Kiểu dữ liệu có thể có tham số

Ngoài ra một số kiểu dữ liệu còn có bí danh (alias), ví dụ như `Int` là bí danh có `Int32` hoặc `Int64`, `Vector` là bí danh của `Array{T, 1} where T`. Kiểu dữ liệu là một trong những lý do chính mà Julia nhanh, nhưng việc đó để cho bài viết khác. Sau khi biết về hệ thống kiểu dữ liệu, ở bài viết sau chúng ta có thể tìm hiểu về *multiple dispatch trong Julia*.
