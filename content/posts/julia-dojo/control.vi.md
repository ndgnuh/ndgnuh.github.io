---
title: "Julia Dojo: cấu trúc điều khiển trong Julia"
date: 2020-01-28T12:04:27+07:00
draft: false
url: "/julia-dojo/re-nhanh-va-lap-trong-julia"
summary: "Cấu trúc điều kiện và lặp trong Julia"
description: "Cấu trúc điều kiện và lặp trong Julia"
lastmod: 2020-01-30T00:05:21+07:00
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
- lập trình Julia
- hướng dẫn lập trình Julia
---

Chào mừng các bạn trở lại với Julia Dojo. Chúng ta đã tìm hiểu về cách khai báo biến và làm việc với một số kiểu dữ liệu trong bài viết [biến số, kiểu dữ liệu, phép toán](/julia-dojo/bien-so-va-kieu-du-lieu-trong-julia). Nhưng một chương trình chỉ có gán, gọi hàm và phép toán không thì không đủ, do đó, chúng ta ta có các cấu trúc điều khiển.

{{< expand "Nội dung chỉnh sửa">}}
29/01/2020:
    - thêm phần lặp for, lặp với bước nhảy không phải 1
    - thêm phần khối lệnh (vốn định đưa sang bài hàm, nhưng thôi)
{{< /expand >}}

## Khối lệnh
Đến phần này, chúng ta sẽ phải biết cách nhận biết một khối lệnh trong Julia. Trong các ngôn ngữ như C hoặc Java, chúng ta dùng một cặp { } để đánh dấu các dòng lệnh. Ở đây chúng tôi không làm vậy.

{{<notice error>}}
Lỗi: meme được dùng đi dùng lại quá nhiều
{{< /notice >}}

Thay vào đó, *mỗi* từ khóa `end` sẽ được kết hợp với các từ khóa lặp, khai báo hàm, rẽ nhánh, v.v... ở đầu của một khối lệnh. Một cặp "từ khóa mở đầu - end" sẽ đánh dấu một khối lệnh trong Julia. Khối lệnh đơn giản nhất trong Julia, là... một khối lệnh theo đúng nghĩa. Nó bắt đầu với từ khóa `begin`, mình thường dùng khi phép gán của mình có một biểu thức rất dài, nên muốn chia nó thành các biến phụ cho đỡ rối mắt.
```julia
z = begin
    local x = 1
    local y = 2 # tưởng tượng nó rất dài hộ mình :)
    x + y
end
```

Khối lệnh sẽ trả ra giá trị ứng với biểu thức ứng cuối cùng của nó (tức `x + y` trong ví dụ trên). Ngoài ra chúng ta cũng có thể dùng từ khóa `return` để trả về một giá trị và kết thúc việc thực hiện khối lệnh. Hãy cẩn thận, khối `begin` có thể thay đổi biến toàn cục mà không báo trước, đó cũng là lí do mình dùng từ khóa `local` ở trên. 

Nếu bạn không thích dùng `begin`, `end` chúng ta cũng có thể viết:
```julia
z = (local x = 1; local y = 2; x + y)
z = (local x = 1;
    local y = 2;
    x + y)
```

## Mình là người có điều kiện

### If...
Hãy thử tượng tượng phải lập trình nhưng không được dùng các cấu trúc rẽ nhánh xem. Bạn sẽ làm ra một chương trình mà, hoặc không thể sử dụng được, hoặc chứa một đống các loại đa hình để thay cho cấu trúc rẽ nhánh (cũng không lí tưởng lắm!). Vậy nên, tội gì không sử dụng if - else cho cuộc sống dễ dàng.
```julia
x = rand(-1:1)
if x == 1
    println(x)
elseif x == 0
    println(x + 1)
else
    println(x + 2)
end
```

Chúc mừng, bạn đã viết thành công chương trình in ra số 1 (dùng if - else - end). Trong cấu trúc rẽ nhánh, các từ khóa `elseif`, `else` là không bắt buộc, nếu bạn không có nhiều trường hợp thì không phải viết chúng.

Nếu các bạn đang tự hỏi Julia có cấu trúc `switch` hay không, mình trả lời luôn là không, lí do là... không cần thiết. Thực chất cấu trúc `switch` có thể được thay thế bằng `if` và một đống `elseif`, mỗi điều kiện chính là một `case`, và `else` chính là `default`.

### Toán tử ba ngôi
Trong Julia, mọi cấu trúc `if` đều trả về một giá trị nào đó. Bạn hoàn toàn có thể viết như sau:
```julia
@show a = rand(0:1) # a nhận giá trị 0 hoặc 1, ngẫu nhiên
b = if a == 0
    0
else
    1
end; println("b = $b")
```

Đoạn chương trình trên... in ra số 0 và gắn `b` bằng `a` rồi in ra `b`. Giá trị của if trả về chính là câu lệnh cuối cùng mà nó chạy. nhưng nếu thích bạn có thể viết từ khóa `return` để "trang trí".
```julia
b = if a == 0
    return 0
else
    return 1
end
```

Nhưng mà thực sự, đừng làm như vậy :) Chúng ta có toán tử ba ngôi cho những việc như thế này.
```julia
a = rand(0:1)
b = (a == 1) ? 1 : 0
```

Vẫn là chương trình random `a` rồi gán `b` bằng `a`, nhưng gọn hơn rất nhiều (*mình không nói là cách gọn nhất...*). Dấu ngoặc bao quanh điều kiện là không cần thiết, nhưng mình viết vậy vì nó dễ nhìn.

Nếu dùng `@show` lên toán tử ba ngôi, chúng ta sẽ thấy nó chỉ là một khối if được đơn giản hóa.
```julia
julia> @show (x == 1) ? 1 : 0
if x == 1
    1
else
    0
end = 1
1
```


### Phạm vi của biến trong if
Những biến được khai báo trong khối `if` sẽ tồn tại ở cả bên ngoài khối. Ví dụ trong đoạn code dưới đây:
```julia
if rand(Bool)
    x = 1
else
    x = 10
end
@show x
```

Nếu biến `x` chưa tồn tại, nó sẽ được khai báo. Nếu nó đã tồn tại, giá trị của nó sẽ được thay đổi. Việc thêm từ khóa `local` sẽ không có tác dụng gì. Nói cách khác, khối `if` có *cùng phạm vi biến (scope) với khối lệnh chứa nó* 

## Lặp, lặp, lặp, lặp, lặp, lặp, lặp, lặp, lặp, lặp, lặp, lặp, lặp...
Thử tưởng tượng lập trình mà không có vòng lặp xem (thực ra các bạn có thể dùng đệ quy thay cho vòng lặp, nhưng mình thấy lặp vẵn dễ sống hơn!). Vòng lặp khác với hai khối trên (ngoài việc nó lặp) ở chỗ: nó không trả về giá trị gì cả, trừ khi bạn ném từ khóa `return` vào trong vòng lặp.

Julia cung cấp cho chúng ta hai loại vòng lặp: `for` và `while`, hãy cùng tìm hiểu chúng.

### Vòng lặp for
Đầu tiên chúng ta có vòng lặp `for` để lặp với số lần xác định trước:
```julia
for i = 1:10
    println(i)
end
for i = 1:2:10 # lặp với bước nhảy 2, mặc định bước nhảy là 1
    println(i) 
end
```

Bạn cũng có thể dùng lặp với từng phần tử của một tập hợp hay một mảng nào đó.
```julia
arr = [1, 2, 3]
for x in arr
    println(x)
end
```

Chúng ta cũng có thể lặp qua một xâu kí tự:
```julia
s = "xin chào"
for i = 1:length(s)
    println(s[i])
end
```

Khi chạy đoạn code trên, chúng ta sẽ thu được... lỗi.
```shell
ERROR: StringIndexError("xin chào", 8)
Stacktrace:
 [1] string_index_err(::String, ::Int64) at ./strings/string.jl:12
 [2] getindex_continued(::String, ::Int64, ::UInt32) at ./strings/string.jl:220
 [3] getindex(::String, ::Int64) at ./strings/string.jl:213
 [4] top-level scope at ./REPL[4]:2
```

Điều này xảy ra vì Julia hỗ trợ unicode, do đó không phải string nào cũng là ascii (bạn có thể kiểm tra bằng hàm `isascii`). Những kí tự không nằm trong bảng ascii sẽ chiếm một số lượng index không xác định. Vậy muốn lặp qua một xâu kí tự an toàn thì làm như thế nào?

```julia
for i in eachindex(s)
    println(s[i])
end
```

Hàm `eachindex` sẽ sinh ra một bộ chỉ số của xâu `s` và bạn có thể lặp qua từng kí tự của `s` một cách an toàn. Hơn nữa, `eachindex` nhìn đẹp hơn `1:length(s)`. Nếu bạn không cần chỉ số mà chỉ cần kí tự, bạn có thể lặp như sau:
```julia
for c in s
    println(c)
end
```

Không chỉ với string, `eachindex` hoạt động với *tất cả các kiễu dữ liệu có thể lặp được* (nói sau nhé), bao gồm cả mảng, ma trận. Nếu mình không nhầm, dùng nó cũng có lợi về hiệu năng hơn vì Julia sẽ không phải kiểm tra việc đánh chỉ số có đúng hay không.

Bạn có thể dùng nhiều vòng lặp lồng nhau như các ngôn ngữ lập trình khác:
```julia
for i = 1:2
    for j = 3:4
        for k = 5:6
            @show (i, j, k)
        end
    end
end
```

Trong trường hợp vòng lặp bên ngoài không có nhiệm vụ gì ngoài gọi vòng lặp con như trên, code của chúng ta sẽ trông như cái tam giác trống, nhìn hơi tù. Julia cung cấp cho chúng ta cách chồng các vòng lặp lên nhau.
```julia
for i=1:2, j=3:4, k=5:6
    @show (i, j, k)
end
```

Đoạn code này sẽ in ra cùng một kết quả như trên, nhưng lại gọn gàng và dễ nhìn hơn. Dù sao, nếu bạn phải dùng tới ba bốn vòng lặp, logic trong code của bạn có thể đã trở nên phức tạp và đó là dấu hiệu của việc bạn nên viết *hàm*.

### Vòng lặp while

Cấu trúc lặp `while` thì mạnh mẽ hơn lặp `for` rất nhiều, nó có thể dùng để lặp với số lần lặp không xác định (hoặc có, nhưng đó là việc của `for`). Vòng lặp `while` không có nhiều thứ cần đặc biệt lưu ý giống như `for`, các bạn có thể dùng nó với cú pháp như sau:
```julia
điều_kiện = true # biểu thức điều kiện
while điều_kiện
    # làm gì đó
    # với dữ liệu
end
```

### Phạm vi biến của cấu trúc lặp

Vòng lặp trong julia có phạm vi biến riêng. Điều đó có nghĩa, các vòng lặp sẽ không thay đổi các biến toàn cục một các tùy tiện.
```julia
# phạm vi toàn cục (global scope)
x = 10
for i = 1:10
    x = i # biến i vẫn truy cập được
end
@show x # x vẫn là 10
```

Tuy nhiên, khi vòng lặp được lồng trong một phạm vi nội bộ (một vòng lặp khác, một hàm), chúng *có thể* cập nhật biến trong phạm vi đó:
```julia
for i = 1:2
    x = i
    for j = 3:4
        x = x * j
    end
    @show x # biến x sẽ thay đổi
end
```

Nếu bạn muốn thay đổi biến toàn cục, hãy dùng từ khóa `global`:
```julia
x = 10
for i = 1:5
    global x *= i
end
@show x # x = 1200
```

### Thoát lặp, nhảy lặp

Nếu bạn đang lặp mà muốn dừng giữa chừng, bạn có thể dùng `break` để thoát hoàn toàn khỏi vòng lặp.
```julia
đếm = 1
while true
    global đếm += 1
    if đếm == 4
        break
    end
end
```

Nếu vì lí do nào đó, bạn muốn nhảy cóc một vòng lặp, bạn có thể dùng từ khóa `continue`.
```julia
for i = 1:4
    if i == 3
        continue
    else
        @show i
    end
end
```

Với những đoạn rẽ nhánh đơn giản như trên, chúng ta có thể dùng kết hợp với toán tử ba ngôi cho gọn:
```julia
for i = 1:4
    i == 3 ? continue : @show i
end
```

## Tạm kết

Sau khi biết được các cấu trúc điều khiển cơ bản. Hãy nhớ rằng nếu bạn lồng quá nhiều cấu trúc điều khiển với nhau, bạn có thể đang cần tách logic trong code ra thành một hàm. Viết hàm thế nào, hồi sau sẽ rõ :) Hẹn gặp lại các bạn ở bài viết sau.
