---
title: "Julia Dojo: từ điển & tập hợp"
date: 2020-02-27T17:30:13+07:00
draft: false
url: "/julia-dojo/tu-dien-va-tap-hop-trong-julia"
summary: "Kiểu dữ liệu tập hợp, kiểu dữ liệu từ điển trong Julia"
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

Chào các bạn trở lại với Julia Dojo, trong bài viết này, mình sẽ hướng dẫn về một số các kiểu dữ liệu dưới dạng tập hợp, `Dict` (từ điển), `Set` (tập hợp)

## Từ điển

Trong Julia có rất nhiều kiểu từ điển, nhưng hai kiểu mình thấy hay gặp nhất là `Dict` và `ImmutableDict`. Từ điển sẽ tạo một bảng băm để ta "chiếu" các giá trị, cú pháp để làm việc với từ điển `Dict` như sau:
```julia
d = Dict(
    1 => "số một",
    2 => "số hai",
    10 => "số mười")
d[1] # lấy ra giá trị
d[3] = "abc" # thêm một giá trị vào từ điển
keys(d) # lấy ra các khóa
values(d) # lấy ra các giá trị
```

Kiểu từ điển có hai tham số kiểu: `Dict{K, V}`, trong đó `K` là kiểu của khóa, `V` là kiểu của giá trị trỏ bởi khóa đó. Bạn có thể định kiểu một cách tường minh cho từ điển:

```julia
d = Dict{String, Number}()
d["thực"] = 1.0
d["ảo"] = 1+2im
```

Ngoài ra, các bạn có thể "thu thập các giá trị của từ điển để tạo thành một mảng gồm các cặp (`Pair`), hoặc lặp qua một từ điểm trong một vòng lặp:
```julia
collect(d) # thu thập
for (k,v) in d
    println("khóa $k: giá trị $v")
end
```

Đối với `ImmutableDict` cách làm việc hơi khác một chút so với `Dict`. `Immutable` nghĩa là bạn sẽ không thể chỉnh sửa nó được, do đó chúng ta không thể:
- thêm khóa
- xóa một khóa

ImmutableDict được cài đặt như một danh sách liên kết, vậy nên nó sử dụng nó sẽ hiệu quả hơn khi bạn cần thêm liên tục. Nghe nghịch lý vì chúng ta không thể thay đổi được ImmutableDict, nhưng thực chất nó sẽ tạo một từ điển mới mỗi lần ta thêm khóa:
```julia
ImmutableDict = Base.ImmutableDict # không nằm sẵn trong global scope
d = ImmutableDict(:a => 1) # trả về một từ điển mới, với 1 khóa
d = ImmutableDict(d, :b => 1) # trả về một từ điển mới, vởi 2 khóa
```

Ngoài những điều trên ra, bạn vẫn có thể thực hiện các thao tác giống như Dict một cách bình thường


## Tập hợp

Tập hợp là kiểu được cài đặt giống với định nghĩa toán học tương ứng. Đây là kiểu dữ liệu khá đơn giản nên mình chỉ giới thiệu cú pháp sử dụng thôi:

```julia
s1 = Set([1, 2, 3])
s2 = Set([3, 3, 4, 5, 6]) # sẽ tự bỏ phần tử trùng
s1 ∪ s1 # hợp, viết bằng cách \cup<tab>
s1 ∩ s2 # giao, viết bằng cách \cap<tab>
setdiff(s1, s2) # hiệu tập hợp s1 \ s2
for x in s1 @show x end # lặp qua tập hợp
filter(x -> x < 3, s1) # lọc phần tử
filter(s1) do # cũng là lọc phần tử
    x < 3
end
collect(s1) # đưa thành mảng
```

## Tạm kết
Ok, bài này mình sẽ kết thúc ở đây. Qua bài này chúng ta đã biết cách thao tác với từ điển và tập hợp. Ngoài ra, bạn có thể tham khảo thêm các kiểu từ điển khác như `IdDict` hay `WeakKeyDict` tại tài liệu chính thức của [Julia](https://docs.julialang.org). Hẹn gặp lại các bạn torng những bài viết sau.
