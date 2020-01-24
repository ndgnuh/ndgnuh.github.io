---
title: "Julia từ con số không: biến số, hằng số, dữ liệu số"
date: 2020-01-24T18:20:07+07:00
draft: true
summary: "Một số kiểu dữ liệu số cơ bản trong Julia và một số phép toán áp dụng với chúng"
tags:
- julia
- lập trình
---

Chào mừng các bạn trở lại với "Julia từ con số không". Trong bài viết này, mình sẽ giới thiệu nhanh một số kiểu dữ liệu số học trong Julia, đặc tính và cách sử dụng chúng. Qua việc giới thiệu này, chúng ta cũng sẽ luyện tập viết một số đoạn code Julia đơn giản. 

{{<notice note>}}
Trong bài mình có dùng một số kí tự đặc biệt, cách viết của chúng rất giống với LaTeX. Nếu bạn không biết LaTeX, hãy mở REPL ra, gõ `?` để vào help mode và paste kí tự đó vào. REPL sẽ hiển thị cách gõ và hàm thay thế (nếu bạn không muốn dùng những kí tự này)
{{</notice>}}

Vì đây là lần đầu tiên chúng ta làm việc với

## Biến số, hằng số

Khai báo biến số trong Julia rất đơn giản:

```julia
x = 10
s = "Chào"
```

Biến `x` sẽ có giá trị 10 và tự được định kiểu `Int`. Bạn cũng có thể dùng tính năng tab completion để tạo những biến có kí tự đặc biệt, thậm chí là những biến số tiếng Việt nếu cần

```julia
ε = 1e-9
こんにちは世界 = "Hello world, google dịch vậy :)"
```

{{<notice note>}}
Mình thấy tính năng này được dùng chủ yếu cho các kí hiệu toán học nhằm làm mã nguồn dễ theo dõi hơn. Do đó, trừ khi công việc yêu cầu, hoặc bạn cảm thấy rất muốn dùng tiếng Việt có dấu, tiếng Nhật, Hàn hay Trung để code, mình khuyên các bạn dùng tên biến không có dấu, hoặc viết tiếng Anh để dễ đọc và viết ∘⌣∘.
{{</notice>}}

Khai báo hằng số trong Julia cũng rất dễ, chúng ta làm y hệt như lúc khai báo biến số, nhưng thêm từ khóa `const` ở đầu:

```julia
const e = 2.7182818284590
```

## Các kiểu dữ liệu số

### Kiểu nguyên

Julia cung cấp cho các bạn một số loại số nguyên. Đầu tiên, mình xin giới thiệu về nhóm `Int8`, `Int16`, `Int32`, `Int64`, `Int128` là các kiểu số nguyên có dấu, được biểu diễn với số bit tương ứng trong tên của chúng. Tuy nhiên bạn không cần phải định kiểu khi khai báo biến nguyên. Dưới dây là cách khai báo cùng với một số phép toán cơ bản với kiểu nguyên.

```julia
a = 7
b = 4
a + b # cộng -> 11
a - b # trừ -> 3
a * b # nhân -> 28
a / b # chia (bị ép kiểu) -> 1.75
a \ b # chia (ngược, bị ép kiểu) -> 0.5714285714285714
a % b # lấy số dư -> 3
div(a, b) # chia (không ép kiểu) -> 1
          # có thể thay bằng phép \div -> a ÷ b
a ^ b # lấy lũy thừa -> 7^4 = 2401
sqrt(a) # lấy căn (ép kiểu) -> 2.6457513110645907
        # có thể thay bằng dấu \sqrt -> √7
```

Ngoài ra chúng ta cũng có các phép so sánh:
```julia
5 > 4 # true
5 < 4 # false
4 ≥ 4 # true, có thể dùng 4 >= 4
4 ≤ 4 # true, có thể dùng 4 <= 4
4 ≠ 4 # false, có thể dùng 4 != 4
4 == 4 # true
```

Bạn có thể định kiểu số nguyên bằng cú pháp `KiểuDữLiệu(biến_hoặc_giá_trị)`.
- Nếu ép kiểu một số lớn hơn độ chính xác mà kiểu dữ liệu biểu diễn được, Julia sẽ báo lỗi
- Nếu cộng hai số nguyên bị tràn, Julia REPL sẽ không báo lỗi, thay vào đó trả về kết quả khi đã tràn số

```julia
Int8(128) # gây ra InexactError, lỗi khi ép kiểu không chính xác
Int8(127) + Int8(1) # trả về -128
```

Khi thêm đầu `U` vào các kiểu dữ liệu trên, ta được phiên bản không dấu của chúng.
```julia
UInt8(255) # không lỗi
UInt8(256) # InexactError
UInt8(255) + UInt8(1) # trả về 0
UInt8(255) + Int8(1) # trả về 0
```

Tiếp theo, chúng ta có kiểu `BigInt`, dùng để biếu diễn các số nguyên *rất* lớn, với một độ chính xác nào đó. Không có phiên bản không dấu của `BigInt`.

```julia
BigInt(10^5) ^ BigInt(10^5) # rất nhiều số 0
```

Cuối cùng, chúng ta có hai kiểu số nguyên khá đặc biệt: `Int` và `UInt`. Thực ra đây là hai kiểu nguyên mà sẽ tự động chuyển về `Int32`, `Int64` (hoặc `UInt32`, `UInt64`) tùy theo số từ máy của bạn. Nếu hệ điều hành bạn đang dùng là 32bit, `Int` thực chất sẽ là `Int32`, ngược lại, nếu bạn đang dùng hệ điều hành 64 bit, `Int` sẽ là `Int64`.

{{<notice note>}}
Điều này không có nghĩa rằng bạn không thể dùng các kiểu dữ liệu 64 hay 128 trong hệ điều hành 32bit.
{{</notice>}}

### Kiểu float

Julia cũng cung cấp một số độ chính xác của kiểu float (nhưng ít hơn kiểu nguyên)

```julia
Float16(1) # kiểu Float16
1f0 # kiểu Float32
1e0 # kiểu Float64
eps(1.23) # khoảng cách đến số thực tiếp
          # theo mà có thể biểu diễn được của 1.23
```

Các thao tác tính toán với float rất giống với kiểu nguyên. Ngoài ra, kiểu float có các giá trị đặc biệt như vô cùng, hoặc not-a-number (NaN). Tương ứng với ba kiểu `Float16/32/64`, chúng ta có `Inf16/32/64`, `Nan16/32/64`. Giống với `Int` và `UInt`, `NaN` và `Inf` biểu diễn giá trị vô cùng tùy theo số từ máy. Dưới đây mình xin giới thiệu một số thao tác đặc biệt có liên quan tới float.

```julia
1.0 / 0.0 # trả về Inf
1.0 % 0.0 # trả về NaN
nextfloat(1.5) # số float tiếp theo 1.5
prevfloat(1.5) # số float liền trước 1.5
1.05 ≈ 1 # (\approx) kiểm tra xấp xỉ, trả về false
1.000000000005 ≈ 1.0 # true
1 ≈ 1.0 #  true
Int(3.0) # ép về số nguyên, trả về 3
Int(3.2) # lỗi
1 < Inf # true, Inf lớn hơn mọi số
1 > -Inf # true, -Inf bé hơn mọi số
NaN + 1 # NaN, mọi phép toán với NaN trả về NaN
NaN == 1 # false, mọi phép so sánh với NaN đều false
NaN == NaN # false, tương tự
isnan(NaN) # true, kiểm tra 1 biến có phải NaN hay không
```

Ngoài ra Julia cũng cung cấp kiểu `BigFloat`, với tác dụng giống như `BigInt`. Tuy nhiên, Julia không có alias `Float` như kiểu `Int` hay `UInt`.


### Số hữu tỉ và số vô tỉ

Đây là hai kiểu dữ liệu khá mới lạ, mình cũng chưa biết nhiều về ứng dụng của nó. Biến hữu tỉ được biểu diễn dưới dạng các phân số.

```julia
a = 1//3
b = 1//2
a + b # trả về kết quả 5//6
a * b # 1//6
a / b # 2//3
a \ b # 3//2
Float32(1//2) # 0.5f0
Int(1//3) # lỗi
2 // 4 # tự động tối giản về 1//2
```

Kiểu vô tỉ thì đơn giản là... bạn không có cách để tạo ra nó. Kiểu này được dùng cho những hằng số như `pi` (hay `π`) và hằng số Euler `ℯ`.

```julia
julia> π
π = 3.1415926535897...

julia> ℯ
ℯ = 2.7182818284590...

julia> typeof(π)
Irrational{:π}
```

## Tạm kết

Toàn bộ bài viết này... là những phần cơ bản nhất của Julia. Chỉ với những kiểu dữ liệu đơn giản



