---
title: "Julia dojo: nói thêm về kiểu dữ liệu"
date: 2020-03-18T22:22:23+07:00
draft: true
---

Chào các bạn trở lại với Julia Dojo, đã khá lâu rồi mình không đăng bài. Điều đó không có nghĩa mình quit đâu :) Ở các bài viết trước mình đã giới thiệu một số kiểu dữ liệu cơ bản như số, từ điển, mảng. Trong bài viết này chúng ta sẽ khám phá một các tổng quan hơn về hệ thống kiểu dữ liệu của Julia.

## Động, nhưng không hẳn

Mặc dù Julia có hệ thống kiểu dữ liệu, Julia vẫn có những lợi thế của hệ thống kiểu tĩnh bằng khả năng định kiểu dữ liệu cho các giá trị. Lợi thế tuyệt vời nhất là: hệ thống kiểu này cho phép *dispatch* dựa trên kiểu dữ liệu trong bất kì hàm nào.

Mình không biết dịch dispatch là gì, bạn hiểu nôm na rằng, khi code chạy và hàm được gọi, kiểu dữ liệu của các tham số đều sẽ được biết hết, do đó Julia có thể tạo ra một phương thức phù hợp cho kiểu dữ liệu đó, compile nó thành mã máy và chạy. Điều này xảy ra với mọi hàm, bất kể bạn gọi nó ở đâu, do đó, bạn có thể *viết hàm mà không cần định kiểu* nhưng *code vẫn có thể chặt chẽ và nhanh*.

Ví dụ như hàm `map`, hàm này nhận vào 1 hàm `f`, một mảng `xs` (không hẳn là mảng, nhưng mình sẽ nói sau), trả về một mảng khác với các phần tử của nó là `f(x)` với `x` thuộc `xs`. Đoạn code dưới đây sẽ chạy ngon lành mặc dù mình không định kiểu cho hàm `x -> x * ...`.
```julia
map(x -> x * 1, [1,2,3])
map(x -> x * "!", ["a", "b", "c"])
```

## Định kiểu cho một giá trị

Mặc dù mình nói ở trên bạn có thể viết hàm mà không cần định kiểu, nhưng đôi lúc bạn sẽ cần phải làm chuyện ấy. Một số lý do chúng ta sẽ muốn định kiểu:
- Đưa ra quy tắc, giúp phần mềm của chúng ta sẽ chạy như mong muốn
- Đưa thêm thông tin cho bộ dịch, có thể cải thiện hiệu năng trong một số trường hợp (nói sau)

Vậy chúng ta làm thế nào để gắn một kiểu dữ liệu vào giá trị? Chúng ta sẽ dùng phép toán `::` ("phát âm": *là một thực thể thuộc ...*). Cú pháp:
```julia
# môt điều mình thích ở Julia là:
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
Trong ví dụ ở trên, mình có lấy một kiểu là `AbstractFloat`, đó chính là một hình ảnh về kiểu trừu tượng (phân biệt với *kiểu dữ liệu trừu tượng* nhé).

Để hiểu về kiểu trừu tượng trong Julia, hãy tưởng tượng một đồ thị có hướng, mỗi nút là một kiểu dữ liệu, và `A` → `B` có nghĩa rằng: kiểu `B` kế thừa mọi *hành động* từ kiểu `A`.

Kiểu trừu tượng trong Julia đóng vai trò là một nút phụ trong cái đồ thị trên. Ngoài ra nó không có chức năng gì khác =)) Nghe như đùa nhưng nó là thật và lại vô cùng hiệu quả
