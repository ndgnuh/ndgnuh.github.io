---
title: "Pluto.jl: Reactive notebook cho Julia"
date: 2020-09-15T20:28:54+07:00
draft: false
summary: "Một luồng làm việc mới với Pluto.jl - reactive notebook"
categories:
- hướng dẫn
- lập trình
tags:
- julia
- pluto
- plutojl
- reactive
- reactive notebook
keywords:
- julia
- lập trình
- học lập trình
- ngôn ngữ julia
- julia dojo
- julialang
- hướng dẫn
- reactive
- reactive notebook
- notebook
- jupyter notebook
- pluto
- plutojl
---

Cuối tháng 7 năm 2020, tại hội nghị Julia hàng năm, các nhà phát triển Julia đã giới thiệu một công cụ mới dạng Notebook giống như Jupyter để làm việc với Julia, đó chính là Pluto. Pluto có những ưu nhược điểm, tính năng gì khác so với hệ sinh thái Jupyter?

## Giới thiệu sơ lược

Như đã nói ở trên, Pluto là loại notebook giống như notebook của một Jupyter. Điều đó có nghĩa, luồng làm việc Pluto cũng được chia thành các ô (cell), bao gồm ô code và ô markdown; khi người dùng khởi động Pluto, nó cũng tạo một webserver ở localhost để người dùng truy cập giống Jupyter.

![Cửa sổ làm việc của Pluto](/img/plutojl-01.svg)

Pluto được viết bằng Julia, và là một gói Julia. Người dùng có thể cài đặt Pluto bằng cách chạy
```julia
]add Pluto
```
trong Julia REPL. Cuối cùng, để chạy Pluto thì:
```julia
using Pluto
Pluto.run(1234) # số port để mở, mặc định là 1234
```

![Chào mừng tới Pluto](/img/plutojl-02.svg)

## Reactive notebook

Đây là khác biệt đầu tiên của Pluto với Jupyter. Reactive ở đây có nghĩa, nếu có một thông tin ở cell này bị thay đổi thì những cell khác phụ thuộc vào nó cũng được "đánh giá" (chạy) lại.

![Reactive notebook (gif)](/img/plutojl-03.gif)

Điều này sẽ dẫn đến một số khác biệt khác so giữa Pluto và Jupyter. Đầu tiên, mỗi cell chỉ được có một biểu thức (expression). Nếu cố dùng hai expression trong một cell, chúng ta nhận được một thông báo lỗi như sau.

![](/img/plutojl-04.png)

Như trong thông báo lỗi, có hai cách để xử lý; hoặc chúng ta dùng một khối `begin ... end` bao quanh đoạn code, khi đó khối `begin` sẽ trở thành một biểu thức; hoặc tách những biểu thức trên thành những cell khác nhau. Lý do cho việc này là cách hoạt động (nội bộ) của Pluto - thứ mà bài viết sẽ không đề cập. Hơn nữa, như trong hình, nếu xóa một cell đi thì *biến được định nghĩa trong cell đó sẽ không tồn tại*.

Hệ quả tiếp theo là mỗi biến chỉ được định nghĩa một lần. Điều này tất yếu vì: để phát hiện một thông tin thay đổi, Pluto cần một nguồn tin cậy để đối chiếu. Cố tình khai báo hai lần sẽ tạo ra lỗi `Multiple definitions` như sau:

![](/img/plutojl-05.png)

Ok, mỗi thứ chỉ được định nghĩa một lần. Nhưng ngôn ngữ dùng multiple dispatch, nếu muốn khai báo nhiều method thì sao? Câu trả lời là khối `begin`.

![](/img/plutojl-06.png)

Để định nghĩa nhiều method, chúng ta định nghĩa tất cả chúng vào một khối `begin`. Tất cả những cell gọi hàm được khai báo sẽ được đánh giá lại khi có một method thay đổi. Tương tự, chúng ta dùng khối `begin` để cũng có thể viết docstring.

Đổi sang những điểm bất tương đồng nhỏ khác:
- Các cell trong Pluto không đánh thứ tự từ trên xuống dưới (theo mắt người nhìn), mà sẽ chạy theo thứ tự cần thiết. Hệ thống Pluto sẽ tự phát hiện điều này
- Struct cũng như tất cả mọi thứ trong Pluto có thể định nghĩa lại thoải mái, không phải wrap trong module như trên REPL hoặc Jupyter.
- File notebook sẽ được lưu trực tiếp thành một file Julia, quá trình lưu diễn ra tự động (nếu người dùng có lưu file). Điều này có nghĩa: người dùng có thể mở file Julia trên bằng REPL hay bất kì công cụ nào khác, file đó sẽ chạy y hệt như trên notebook.

## Markdown, HTML, Latex, PlutoUI

Dù ở đầu bài viết nói Pluto có markdown cell, nhưng thực chất chúng là một cell code trả về với kiểu dữ liệu `MD` (markdown) trong Julia. Julia cung cấp macro tiện lợi cho chúng ta như sau:
```julia
md"# Title"
md"""
- x
- y
- z
"""
```

Tương tự, chúng ta có thể dùng kiểu `HTML` để trên Pluto. Tuy nhiên, cách gõ Latex (không hẳn là Latex) thì hơi khác biệt một chút. Julia dùng hai dấu backtick ` `` `để dánh dấu code Latex.
```julia
md"Toán: ``x + 2``"
```

![](/img/plutojl-07.png)

Điều thú vị ở đây là các input của html được render và hoạt động bình thường, khiến chúng ta băn khoăn: không biết có cách nào để "khai báo" một biến số từ những giá trị được nhập vào này không? Tất nhiên là có. Pluto cung cấp macro `@bind` để thực hiện việc này. Cú pháp:
```julia
@bind <tên biến số> html"<input .... />"
```

![](/img/plutojl-08.gif)

Giờ chúng ta không cần phải trực tiếp thay đổi cell code nữa, mà chỉ cần nhập số khác hoặc kéo cái slider, tiết kiệm một cơ số thao tác. Chúng ta cũng có thể nhấn vào nút hình cái mắt bên cạnh cell để ẩn phần code đi và hiện ra mỗi cái widget:

![](/img/plutojl-09.gif)

Để tiện cho việc theo dõi. Chúng ta kết hợp việc sử dụng Markdown để hiện một cái label cạnh input, đồng thời hiện giá trị của biến ở cell dưới:
```julia
# Cell 1
md"""
x: $(@bind x html"<input type='range' min='0' max='1' step='0.1'/>")
"""
# Cell 2
md"x = $x"
```
*Lưu ý* rằng không được dùng `md"x = $x"` ở trong cùng cell khai báo widget vì nó sẽ dẫn đến một vòng lặp đánh giá vô hạn; ở những phiên bản mới Pluto đã ngăn chặn hành vi này.

> Nhưng tôi mù tịt HTML.

Không sao, bên cạnh Pluto, cộng đồng Julia cũng cung cấp một gói là `PlutoUI`, chuyên dùng để render những widget html như trên. Người dùng sẽ không cần biết một chút HTML nào nhưng vẫn có thể dùng các widget. Cú pháp
```julia
@bind <biến số> PlutoUI.TênWidget(thamsố)
```

![](/img/plutojl-10.gif)

Gói PlutoUI không được cài cùng Pluto (vì lý do thiết kế), do đó người dùng phải cài riêng nó với REPL
```julia
]add PlutoUI
```

## Ưu nhược điểm

Đầu tiên, ta bàn về một số ưu điểm của Reactive notebook với những notebook.

Một, reactive notebook khả lặp hơn (more reproducible) hơn so với notebook thông thường. Điều này thể hiện ở một số điểm:
- Không có trạng thái nào bị ẩn đi, một thứ đã bị xóa thì sẽ không tồn tại. Trong notebook bình thường, những trạng thái ẩn có thể thao túng kết quả trong những phiên làm việc khác nhau.
- Không cần quan tâm tới thứ tự các cell, các cell được chạy theo nhu cầu. Trong khi đó, notebook bình thường chạy từ trên xuống, cell bị sắp sai trình tự thì người dùng phải tự sắp xếp lại, tiêu tốn thời gian.

Hai, làm việc trên Pluto có thể thử nghiệm với các struct thoải mái hơn. Nếu dùng notebook thông thường, ta cần viết các struct thử nghiệm trong một module để có thể chỉnh sửa nó khi cần; còn nếu dùng Pluto thì chỉ cần định nghĩa lại struct.

Ba, dễ dàng điều chỉnh các tham số với widget. Đương nhiên, Jupyter notebook cũng có thể có những widget nếu muốn; nhưng vì nó không "reactive", một trạng thái, có thể hiểu là biến số, khi được thay đổi thì cũng không có cách khác nào để nhận biết sự thay đổi đó đem lại kết quả gì. Với tính reactive của Pluto, những thay đổi đó được quan sát và đánh giá, khiến cho việc kết hợp các tham số với widget là khả thi.

Tiếp theo, Pluto cũng có một số nhược điểm so với Jupyter.

Một, khó kiểm soát các tính toán với thời gian tính toán dài. Giả sử ta có một hàm `longcomputation(a, b, c, d)`  thực thi mất rất nhiều thời gian. Giờ hàm này dựa vào bốn biến số `a`, `b`, `c`, `d` được khai báo ở trên. Nhưng mỗi lần chỉnh sửa lại giá trị của *một trong các biến số này*, hàm `longcomputation` lại chạy một lần. Giải phải trước đây chỉ có cách tạo một biến chặn, sau đó đổi giá trị biến chặn đó trước khi đổi biến khác:
```julia
if shouldrun
	longcomputation(a, b, c, d)
end
```
Ở những phiên bản sau, Pluto có thêm một nút là *commit all changes*, cho phép người dùng thay đổi nhiều cell và xác nhận tất cả sự thay đổi *một lần duy nhất*.

![](/img/plutojl-11.gif)

Hai, cũng liên quan tới `longcomputation`. Nhưng giả sử hàm này vì một lý do nào đó (như lặp vô hạn) làm máy của người dùng bị đơ và phải khởi động lại. Nhưng nếu khởi động lại Pluto, hàm đó sẽ lại tự động chạy tiếp. Nếu muốn xử lý vấn đề đó, người dùng đành phải mở file notebook (thực chất là một file mã nguồn Julia) và comment lời gọi hàm đó lại.

Ba, một nhược điểm không hẳn do reactivity, Pluto *chỉ hiện kết quả trả về* chứ *không* hiện những thứ được in bởi `println`, `@show`, `display`... ở trên web. Tạm thời, chúng ta chỉ có thể xem những output này trên REPL mà chạy hàm `Pluto.run()`.

Bốn, Pluto hiện tại không hỗ trợ ngôn ngữ khác, chỉ Julia. Để dùng Python ở đây cần sử dụng thông qua gói PyCall.

## Kết luận

Pluto được tạo ra để giới thiệu một phương thức làm việc mới cho những người nghiên cứu, lập trình viên. Tại thời điểm viết bài, Pluto đang ở phiên bản 0.11.14. Hi vọng trong tương lai, Pluto sẽ được cải thiện để xóa bỏ những bất tiện nêu trên.

Tham khảo:
- [Trình diễn Pluto tại JuliaCon 2020](https://youtu.be/IAF8DjrQSSk)
- [Khóa học "Introduction to Computational Thinking" (MIT 18.S191) với sự đóng góp của Pluto](https://computationalthinking.mit.edu/Fall20/)
- [Chạy thử Pluto trên binder](https://mybinder.org/v2/gh/fonsp/vscode-binder/master?urlpath=pluto)
- [Github của Pluto](https://github.com/fonsp/Pluto.jl)
- [Github của PlutoUI](https://github.com/fonsp/PlutoUI.jl)

Các thông tin khác có thể được tìm thấy trên trang Github của Pluto.
