---
title: "Cài đặt và sử dụng gói Julia"
date: 2020-01-31T00:29:16+07:00
draft: true
url: "/julia-dojo/cai-dat-va-su-dung-goi-julia"
summary: "Hướng dẫn cài đặt và sử dụng các gói trong Julia"
description: "Hướng dẫn cài đặt và sử dụng các gói trong Julia"
lastmod: 2020-01-29T01:12:17+07:00
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
- hướng dẫn lập trình Julia
---

Chào mừng mọi người đến với Julia Dojo. 

Là con người, không phải ai trong số chúng ta cũng có khả năng cân tất cả các việc cùng một lúc, đặc biệt với đống kiến thức tích lũy qua cả trăm năm của nhân loại. Hiển nhiên rằng, một người không thể lập trình mọi thứ từ con số không. Vì vậy, chúng ta có cộng đồng người dùng, có các gói bổ trợ cho một ngôn ngữ lập trình. Trong bài viết ngày hôm nay, chúng ta sẽ tìm hiểu về cách quản lí và sử dụng các gói như vậy trong Julia.

## Quản lí một gói

Julia cung cấp tính năng quản lí gói một cách mặc định trong Julia REPL. Để kích hoạt trình quản lí gói, chúng ta nhấn phím `]` ở trên một dòng trống.

{{< img src="/img/install-use-julia-package-001.png" caption="Giao diện quản lí gói, đầu dòng chuyển thành `pkg>`" >}}

{{< notice info >}}
Mọi đoạn code sau đây được sử dụng trong chế độ quản lí gói của Julia
{{< /notice >}}

Để cài gói trong Julia, chúng ta sử dụng cú pháp `add gói`. Chúng ta có thể cài một hoặc nhiều gói, hoặc dùng link github để cài.
```
add DataFrame IJulia
add https://github.com/tlienart/Franklin.jl
```

Lưu ý rằng link github sẽ tải bản *mới nhất hiện có*, bao gồm cả các tính năng thử nghiệm. Sau khi cài đặt một thời gian, chúng ta sẽ cần update gói
```
update IJulia
update 
```

Lệnh `update` sẽ update toàn bộ gói trong khi `update TênGói` chỉ update một gói được định sẵn thôi.

Kiểm tra những gói được cài đặt:
```
st
st TênGói
```

Nếu có gói không dùng, chúng ta xóa bỏ nó bằng cách
```
rm TênGóiKhôngDùng
```

Khi cài hoặc update gói, những gói phụ thược sẽ được cài đặt theo, khi xóa gói chúng sẽ được tự xóa đi, nên các bạn không cần lo về gói phụ thuộc.

## Sử dụng một gói

Cách sử dụng một gói trong Julia rất đơn giản. Chúng ta có hai từ khóa `import` và `using` (trong chế độ bình thường)
```julia
import TênGói
using TênGói
```

Sử dụng `import` sẽ chỉ nhập tên của gói vào phạm vi toàn cục, trong khi `using` sẽ nhập toàn bộ những hằng số, biến số hoặc hàm mà gói đó xuất ra.
```julia
import Gói1
using Gói2
```

Giả sử `Gói1` có `hàm_a`, `Gói2` có `hàm_b`. Trong ví dụ trên, nếu chúng ta muốn gọi hai hàm:
```julia
Gói1.hàm_a()
hàm_b() # hàm_b được cho ra phạm vi toàn cục
```

Ngoài ra chúng ta có thể chỉ `using` một số thành phần của gói:
```julia
using LinearAlgebra: svd # chỉ hàm svd sẽ được nhập
?svd # xem hàm svd
```

## Môi trường của gói

Trình quản lí gói của Julia quản lí theo môi trường, nhìn lại ảnh phía trên, chúng ta sẽ thấy có phần `(v1.3)` ở trước chữ `pkg>`:

{{< img src="/img/install-use-julia-package-001.png" caption="môi trường mặc định, Julia 1.3" >}}

Phần `v1.3` cho biết *môi trường đang hiện hoạt* của Julia. Hãy hiểu một cách đơn giản:
- Julia có nhiều môi trường khác nhau
- Trong môi trường sẽ có những gói được cài khác nhau
- Môi trường thực chất chỉ là một thư mục, thư mục này chứa một file, file này là danh mục các gói đã được cài
- Nếu môi trường không có gói nào thì sẽ không dùng được gói đó, dù nó đã được cài (`using` gây lỗi)
- Khi làm việc sẽ có một môi trường được kích hoạt (môi trường hiện hành)
- Bạn có thể chuyển giữa các môi trường

{{< notice success >}}
Khi cài một gói mà đã được cài ở môi trường khác, Julia chỉ thêm gói đó vào trong danh mục gói của môi trường hiện hành, chứ không tải hay cài lại. Điều này giúp tránh sự trùng lặp khi cài gói.

Tương tự, việc xóa gói đôi lúc chỉ xóa gói đó khỏi chỉ mục chứ không thực sự xóa nó khỏi ổ đĩa.

Nếu bạn muốn xóa những gói không cài trong môi trường nào, dùng lệnh `gc`.
{{< /notice >}}

Môi trường mặc định của Julia là môi trường có chứa tên phiên bản, đây sẽ là môi trường bạn sử dụng nhiều nhất cho việc nghiên cứu hay nháp. Nếu bạn đổi sang môi trường khác, bạn sẽ thấy phần trong ngoặc cũng thay đổi.

Để chuyển vào một môi trường, ta dùng lệnh activate (trong chế độ quán lí gói).
```
activate /đường/dẫn/tới/thư/mục
```

Để chuyển về môi trường mặc định, chúng ta sử dụng lệnh `activate` mà không truyền tham số vào.

## Một số gói trong Julia

Mình chỉ giới thiệu một số gói thôi, chỗ này không đầy đủ.

Một số gói đi kèm trong Julia, không cần cài đặt (standard library): 

Tên gói | Chức năng
--- | ---
Dates | Làm việc với thời gian
Distributed | Hỗ trợ tính toán song song
LibGit2 | Binding của một thư viện C để làm việc với Git
Libdl | Làm việc với thư viện liên kết động
LinearAlgebra | Đại số tuyến tính, svd, lu, trị riêng ...
SparseArray | Ma trận thưa thớt
SharedArrays | Dữ liệu được lưu trên vùng nhớ chung
Sockets | Làm việc với Unix sockets
Statistics | Công cụ thống kê
Test | Unit testing
Profile | Profile code

Một số gói do cộng đồng viết:

Tên gói | Chức năng
--- | ---
IJulia | Dùng Julia với Jupyter notebook
DataFrames | Bảng dữ liệu
Distributions | Các loại phân phối xác suất
DataStructures | Các loại cấu trúc dữ liệu
DifferentialEquations  | Giải các pt vi phân
JuMP | Công cụ tối ưu 
Plots | Vẽ đồ thị (nhiều backend)
HTTP, Genie, Mux | Công cụ làm Web App, Web API
CUDAnative | Công cụ cho CUDA
PyCall | Gọi python từ Julia
TensorFlow | Wrapper cho TensorFlow
ScikitLearn | Cài đặt lại hoàn toàn ScikitLearn trong Julia

## Tạm kết

Trong bài viết này, chúng ta đã tìm hiểu về:
1. Cách cài đặt, update, xem, xóa và sử dụng gói trong Julia
2. Làm việc với môi trường
3. Một số gói chính thức

Trong bài viết sau, chúng ta sẽ học cách sử dụng Julia với Jupyter notebook hoặc Jupyter lab. Hẹn gặp lại các bạn.

Tham khảo thêm:
- Quản lí gói: https://docs.julialang.org/en/v1.0/stdlib/Pkg/
- Thư viện tiêu chuẩn: https://docs.julialang.org/en/v1/stdlib/Base64/
- Tìm kiếm gói Julia: https://pkg.julialang.org/docs/
