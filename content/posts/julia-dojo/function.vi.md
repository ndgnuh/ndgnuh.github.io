---
title: "Julia Dojo: hàm"
date: 2020-01-30T00:06:10+07:00
url: "/julia-dojo/ham-trong-julia"
draft: false
summary: "Giới thiệu về hàm trong Julia"
description: "Giới thiệu về hàm trong Julia"
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
- hàm trong Julia
- Julia function
- ngôn ngữ
---

Chào mừng các mọi người quay trở lại với series Julia Dojo. Như mình đã giới thiệu, Julia là một ngôn ngữ lập trình hàm, và ngôn ngữ lập trình hàm thì... không thể thiếu hàm. Thậm chí, hàm là thực thể "hạng nhất" của Julia. Trong bài viết này, mình sẽ giới thiệu về cú pháp viết và sử dụng các hàm, cũng như một số trường hợp hay gặp.

{{< notice info >}}
Bài viết chủ yếu giới thiệu các cú pháp để làm việc với hàm nên không nói quá chi tiết. Phần đó được dành cho một bài viết khác
{{< /notice >}}

Như mình nói ở phần cấu trúc điều khiển, nếu cấu trúc điều khiển của bạn quá phức tạp, bạn có thể sẽ phải viết một hàm. Trong bài viết này mình sẽ nói về việc khai báo, phạm vi biến và gọi hàm.

## Khai báo một hàm

### Ba kiểu khai báo

Việc khai báo một hàm trong Julia có thể được làm theo nhiều cách. Cách 1 là dùng khối `function`:
```julia
function tên_hàm(tham_số)
    # thân hàm
    return (giá trị trả về)
end
```

Đoạn code trên là ví dụ đơn giản nhất của một hàm. Từ khóa `return` không thực sự cần thiết, nếu không có `return` hàm trên sẽ trả về giá trị của biểu thức cuối cùng được chạy (giống khối `if`).

Vì Julia là ngôn ngữ động nên hàm trên sẽ chạy với mọi kiểu dữ liệu. Tuy vậy, chúng ta vẫn có thể kiểm soát kiểu dữ liệu của tham số được truyền vào, cũng như kiểu dữ liệu mà hàm trả về.
```julia
# đây chỉ là ví dụ
# đừng viết hàm kiểu này
function cộng_một(n::Int)::Int
    n + 1 # trả về (n + 1) vì đây là biểu thức cuối
end
```

Vì chúng ta chưa tìm hiểu sâu về kiểu dữ liệu nên *tạm thời* hãy viết những hàm mà chạy với tất cả các kiểu (tức là không định kiểu). Những hàm như vậy được gọi là "generic" (tổng quát).

Với những hàm ngắn gọn như vậy, chúng ta có thể dùng hai cú pháp sau:
```julia
cộng_một(n) = n + 1
```

Mình nghĩ họ gọi kiểu hàm trên là hàm "inline". Ngoài việc nhìn trông rất thích mắt (nhìn giống với hàm toán học), nếu được cài đặt đúng cách, khi chúng được gọi, thân hàm sẽ được *thay thế trực tiếp vào phần code đang gọi nó* (tức là code chạy nhanh hơn, không tốn thêm stack).

Trong Julia, chúng ta có thể khai báo các hàm mà không cần đặt tên cho chúng, chỉ cần bỏ phần tên khỏi hàm:
```julia
function(n)
    n + 1
end
```

Những hàm kiểu này thường được dùng làm tham số của một hàm khác. Do dó Julia cung cấp cho chúng ta một cách khai báo tiện gợi hơn:
```julia
n -> n + 1
```

Đương nhiên, nếu muốn chúng ta vẫn có thể gắn tên cho chúng, vì hàm trong Julia có thể được coi là một biến:
```julia
cộng_một = n -> n + 1
cộng_một = function(n) 
     n + 1
end
```

Tuy nhiên, cú pháp với `->` thường được sử dụng cho hàm vô danh, những hàm bạn chỉ dùng một lần rồi vứt, không nên dùng để khai báo một hàm có tên như vậy.

Chúng ta cũng có thể khai báo một hàm là toàn cục hay nội bộ với từ khóa `local` hoặc `global`

```julia
global function our_func()
    # thân hàm
end
local function our_func()
    # thân hàm
end
```

### Tham số mặc định
Trong Julia bạn có thể gắn giá trị mặc định cho tham số của hàm:
```julia
cộng(n, i = 1) = n + 1
```

Khi gọi hàm trên, nếu bạn không truyền tham số `i` thì `i` sẽ nhận giá trị mặc định là `1`
```julia
cộng(10) # trả về 11
```

### Tham số có tên
Ngoài những tham số được sắp theo thứ tự như trên, hàm trong Julia còn hỗ trợ tham số có tên (keyword arguments). Mặc dù không cần thiết, tham số có tên được ngăn cách với tham số "bình thường" bằng dấu `;` (cả khi gọi và khai báo hàm).
```julia
cộng(n; m) = n + m
cộng(10; m = 20) # trả về 20
```

Tham số có tên cũng có thể nhận giá trị mặc định. Khi gọi, thứ tự của tham số này không quan trọng, chỉ cần chúng ta định đúng tên:
```julia
cộng(n; m = 2, p = 3) = n + m + p
cộng(10) # trả về 15
cộng(10; p = 8) # trả về 20
cộng(10; z = 100) # lỗi, không có z
cộng(10, m = 17) # dùng dấu `,` cũng không sao
```

### Tùy lượng tham số

Cuối cùng, chúng ta có một kiểu tham số đặc biệt. Mình nghĩ nó sẽ dễ hiểu hơn với một ví dụ:
```julia
trung_bình(args...) = sum(args) / length(args)
trung_bình(1, 3, 8) # trả về 4
trung_bình(1, 1, 1, 3) # 1.5
trung_bình(1) # 1
```

Hàm `sum` có thể dùng để tính tổng của một mảng, còn `length` dùng để đếm số phần tử. Như vậy, khi khai báo hàm như trên, những tham số được "nhét" vào một mảng và cũng ta thao tác trực tiếp trên mảng đó. Điều đó có nghĩa chúng ta có thể truyền một cách tùy, bao nhiêu tham số cũng được.

## Gọi hàm

Gọi hàm trong Julia rất đơn giản, chúng ta thậm chí đã gọi một số hàm trước đây rồi. Hàm được gọi bằng cú pháp tên_hàm(tham_số; tham_số_có_khóa)
```julia
sort([1, -3, 2]; rev = true) # sắp xếp giảm dần
```

Chúng ta cũng có thể gọi hàm một cách lồng nhau:
```julia
# tạo random mảng 4 phân tử trong khoảng [-9, 9]
# sau đó sắp xếp giảm dần
sort(rand(-9:9, 4); rev = true)
```

Tuy nhiên, với những hàm gọi lồng nhau mà không cần tham số nào khác, kiểu như sau:
```julia
# khai báo
f(x) = x + 1
g(x) = 42x
# gọi hàm
g(f(1))
```

Julia cung cấp cho chúng ta toán tử rất tiện lợi để tổ hợp hàm:
```julia
# cách gõ: \circ<tab>
(g ∘ f)(1) # tương dương với g(f(1))
```

Sự tiện lợi chưa dừng ở đây. Bạn có thể áp dụng một hàm lên một tập hợp giống như lúc làm với toán tử, bằng cách thêm dấu `.` ở giữa tên hàm và tham số truyền vào:
```julia
M = [1 2 3; 2 3 4; 4 5 6]
f(x) = x^2 + 3
f.(M) # lấy mọi phần tử trong ma trận M, mũ 2 rồi cộng 3
```

## Phạm vi biến trong hàm Julia

Giống với các vòng lặp, mọi biến trong hàm của Julia đều mặc định có phạm vi là nội bộ. Hàm có thể thay đổi khai báo hoặc thay đổi biến toàn cục, nhưng phải dùng từ khóa `global`.

### Hàm lồng trong hàm
Như mình nói phần [khai báo hàm](#khai-báo-hàm), chúng ta có thể thay đổi phạm vi của hàm, vậy các hàm `local` dùng ở đâu? Đương nhiên là dùng trong các khối khác, dễ hình dung nhất là "hàm lồng trong hàm".
```julia
function hàm_cha(n)
    # tính toán
    function hàm_con(tham_số_con)
        # thân hàm con
    end
    # tính toán
    while(điều_kiện)
        # tính toán
        for i in một_cái_gì_đó
            # tính toán dùng hàm con vì logic ở đây khá dài
            hàm_con(tham_số_con)
            # tính toán
        end
        # tính toán
    end
end
```

Vì những biến được định nghĩa trong hàm mặc định là `local` - và những hàm trong Julia có thể được coi là một biến, hàm định nghĩa trong hàm mặc định cũng là local. Trong trường hợp trên, `hàm_con` sẽ không bị "rò rỉ" ra ngoài phạm vi toàn cục. Chúng ta cũng có thể khai báo hàm local ở trong các khối khác, không nhất thiết phải trong một hàm:
```julia
for i = 1:3
    cộng_thêm_i(x) = x + i
    for j = 2:3
        @show cộng_thêm_i(j)
    end
end
```

## Hành vi với tham số truyền vào

Trong Julia, đa số các hàm chỉ nhận tham trị và không thay đổi các biến đầu vào. Đương nhiên chúng ta vẫn có những hàm thay đổi tham số của nó. Những hàm này nếu dùng không cẩn thận có thể gây ra những hành vi rất khó đoán, việc phân biệt chúng cũng rất đau đầu trong một số ngôn ngữ. 

May thay, Julia cung cấp một quy ước để định ra những hàm thay đổi tham số truyền vào của chúng. Những hàm này sẽ có một dấu `!` ở sau tên của chúng.
```julia
arr = [1, -3, 2]
sort(arr) # hàm này chỉ trả về mảng đã sắp xếp
@show arr
sort!(arr) # hàm này sắp xếp luôn mảng arr
@show arr
```

Lưu ý rằng đây chỉ là một quy ước, bạn hoàn toàn có thể viết hàm thay đổi tham số đầu vào mà không có dấu `!` trong tên và ngược lại.

## Tạm kết

Mình xin kết thúc bài giới thiệu về hàm ở đây. Vậy là chúng ta đã kết thúc level 1 của Julia Dojo. Tuy vậy, tất cả những thứ trong level này đều mang tính giới thiệu. Điều đó cũng khá hiển nhiên thôi, một ngôn ngữ vừa nhanh vừa tiện để viết, dù nó đơn giản nhưng bạn cũng không mong nó đơn giản tới mức cục mịch chứ? :)

Đừng lo, dù phức tạp đi nữa thì Julia khá dễ vọc, không như kiểu hợp ngữ đâu. Mình sẽ cố giải thích cho các bạn những thứ cơ bản, đến khi đủ để các bạn tự tìm hiểu. Nếu các bạn có thắc mắc hoặc thấy thiếu sót đừng ngại liên hệ. Hẹn gặp mọi người trong những level tiếp theo.
