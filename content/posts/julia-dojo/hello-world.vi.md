---
title: "Julia Dojo: hello world"
date: 2020-01-26T21:34:44+07:00
draft: false
summary: "Viết chương trình đầu tiên của bạn trong Julia"
description: "Viết chương trình đầu tiên của bạn trong Julia"
tags:
- julia
- julia-dojo
- hướng dẫn
keywords:
- julia
- lập trình
- ngôn ngữ julia
- julia dojo
- julialang
- hướng dẫn
---

Chào mừng các bạn quay trở lại với series Julia Dojo. Hôm nay chúng ta sẽ học cách viết một chương trình trong Julia và làm thế nào để chạy nó.

## Chương trình hello world của bạn

Hello world là chương trình rất quen thuộc nếu bạn đã học lập trình trước đây. Nó sẽ cho bạn cái nhìn đầu tiên về cấu trúc ngữ pháp của một ngôn ngữ lập trình. Đầu tiên, hãy mở một trình sửa văn bản, tạo một file tên `hello-world.jl`.

Trước đây, đuôi file `.j` được sử dụng cho ngôn ngữ Julia. Sau này, họ đổi thành `.jl`, cá nhân mình thấy thích cái đuôi file này hơn.

Khi tạo file xong, hãy điền nội dung sau vào file:
```julia
println("hello world")
```

Xong, bạn hãy mở một terminal tại vị trí bạn lưu file trên, sau đó chạy lệnh.

```shell
julia hello-world.jl
```

Dòng chữ "hello world" sẽ được in ra màn hình. Vậy là bạn đã viết và chạy thành công chương trình hello world của mình với Julia.

## Rất nhiều cách để nói "hello world"

Chúng ta sẽ chỉnh sửa chương trình hello world một chút. Ở trên mình dùng hàm `println` để in ra chuỗi `hello world`. Giờ mình sẽ giới thiệu một vài cách khác:

```julia
println("hello world")
print("hello world"); println()
@show "hello world"
@info "hello world"
@warn "hello world"
@error "hello world"
```

Chạy file trên, chúng ta sẽ thu được output:
```
hello world
hello world
"hello world" = "hello world"
[ Info: hello world
┌ Warning: hello world
└ @ Main /tmp/hello-world.jl:6
┌ Error: hello world
└ @ Main /tmp/hello-world.jl:7
```

- Dòng đầu là kết quả của `println`, hàm này sẽ in ra tham số của nó, sau đó in kí tự ngắt dòng.
- Dòng thứ hai là kết quả của `print`, hàm này giống `println` nhưng không in kí tự ngắt dòng, do đó mình phải thêm một hàm `println()` trống ở phía sau.
- Các bạn để ý thêm. Ở dòng số 2 file `hello-world.jl`, mình có dấu `;`. Đấu này không cần thiết khi bạn viết mỗi lệnh trên một dòng. Tuy nhiên nếu bạn cần viết hai lệnh trên cùng dòng thì sẽ cần tới nó để ngắt giữa hai lệnh.
- Ở dòng 3, macro `@show` in ra một điều "hiển nhiên": `"hello world" = "hello world"`. Thực ra, cái này dùng để show ra giá trị của một biến hay hằng số, ở đây chúng ta truyền cho nó một hằng số nên nó in ra củ chuối như vậy... Macro là gì ư? Tạm thời bạn đừng quan tâm, hãy tạm hiểu nó có dấu `@` và làm một cái gì đó cho bạn.
- Ở dòng 4, chúng ta có `@info`. Macro này có tính ghi chú, nó chỉ nhận đầu vào là chuỗi kí tự thôi. `@info` được dùng để đưa ra bản ghi chép (log) cho chương trình của bạn.
- Ở dòng 5, chúng ta có `@warn`. Thằng này giống thằng `@info`, nhưng nó nói với giọng "bố đang cảnh báo mày đấy". Tuy hổ báo nhưng nó sẽ không đừng việc thực thi chương trình của bạn. `@warn` thường được dùng khi một người viết gói chương trình muốn deprecate (tạm dịch là cho lỗi thời, mình không biết dịch như nào cho hay) một tính năng nào đó và cảnh báo người dùng không nên dùng nó.
- Cuối cùng, chúng ta có `@error`. Thằng này nó sẽ cảnh báo và cho chương trình của bạn bay màu luôn. `@error` được dùng rất nhiều. Bạn sẽ gặp nó khi gọi một hàm không tồn tại chẳng hạn.

## Chế độ tương tác

Bạn có thấy viết hẳn một file, chỉ dành cho một dòng code mà in ra hello world có hơi thừa? Nếu vậy hãy mở terminal ra, chạy câu lệnh sau:
```shell
julia
```

Chế độ tương tác Julia (hay Julia REPL) sẽ chào đón bạn với một cái logo ascii (không có mèo đâu, đấy là hình nền của mình :P)

{{< img src="/img/julia-dojo-hello-world-001.png" caption="chế độ tương tác Julia" >}}

Bạn có thể chạy "hello world" bằng cách nhập câu lệnh trên vào và nhấn Enter:

{{< img src="/img/julia-dojo-hello-world-002.png" caption="hello world trong một dòng" >}}

Thậm chí bạn có thể gõ `?println` và xem thông tin về những thứ mình vừa viết ở trên.

{{< img src="/img/julia-dojo-hello-world-003.png" caption="chế độ help" >}}

## Kết luận

Ok, vậy là bạn đã biết những cách đơn giản nhất viết và chạy chương trình Julia (và cũng là chương trình đơn giản nhất luôn). Chúng ta sẽ lần lượt tìm hiểu những phương thức khác trong các bài tiếp theo. Riêng với chế độ tương tác, mình có thể làm một bài nữa, nói về những tính năng của nó. Hẹn gặp lại các bạn trong những bài viết sau :)
