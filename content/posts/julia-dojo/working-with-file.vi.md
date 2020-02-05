---
title: "Julia Dojo: làm việc với file"
date: 2020-02-06T23:34:03+07:00
draft: true
url: "/julia-dojo/file-trong-julia"
summary: "Làm việc với file trong Julia"
categories:
- hướng dẫn
- lập trình
tags:
- julia
series:
- Julia Dojo
keywords:
- file
- tập
- tệp
- julia
- lập trình
- học lập trình
- ngôn ngữ julia
- julia dojo
- julialang
- hướng dẫn
---

Chào mừng mọi người quay trở lại Julia Dojo. Trong level trước mình đã cover kha khá những cú pháp cơ bản trong Julia. Nhưng mọi người có nhận ra rằng, mình chưa nói về cách để nhập dữ liệu?

Nếu bạn được học C trên trường (nếu không học cũng không sao), chắc hẳn bạn đã được dạy cách nhập tay một dữ liệu bằng hàm `scanf`. Trong Julia, bạn cũng có thể làm điều tương tự với hàm `readline`. Nhưng, nếu chúng ta cần đưa vào xử lí những dữ liệu cồng kềnh (không nhất thiết lớn), việc nhập từ tay trở nên không thực dụng. Khi ấy, chúng ta sẽ phải làm việc với file.

## Đọc, ghi file

### Đóng mở file

Để mở một file trong Julia, chúng ta dùng hàm `open`. Hàm này sẽ trả về một con trỏ file
```julia
io = open("đương dẫn tới file")
io = open("đương dẫn tới file", "mode")
```

{{< expand "Các giá trị của mode" >}}
- `"r"`: đọc
- `"w"`: ghi, tạo mới, cắt bớt
- `"a"`: ghi, tạo mới, ghi thêm
- `"r+"`: đọc, ghi
- `"w+"`: đọc, ghi, tạo, cắt bớt
- `"a+"`: đọc, ghi, tạo, ghi thêm

{{< notice info >}}
Đừng lo lắng quá về các chế độ mở file. Trong đa số trường hợp, mình nghĩ bạn không cần quan tâm lắm về cái này.
{{< /notice >}}

{{< /expand >}}


Sau khi làm việc với file xong, đừng quên đóng nó lại:
```julia
close(io)
```

Ngoài ra, bạn có thể dùng cú pháp `do`:
```julia
open("đường dẫn file", mode) do
    # làm gì đó với file
    # file sẽ được tự động đóng
end
```

Nhưng làm việc với file kiểu gì?

### File văn bản
Sau khi mở một file văn bản, bạn có thể tiến hành đọc từ file đó bằng hàm `read` hoặc `readline` để đọc từng dòng.
```julia
read(io) # đọc đến hết dưới dạng kí tự
read(io, String) # đọc đến hết dưới dạng xâu
read(io, Char) # đọc kí tự tiếp theo
while !eof(io)
    # đọc 1 dòng
    # keep = true thì giữ kí tự xuống dòng
    @show readline(io; keep = false) 
end
```

Lưu ý rằng, việc đọc file sẽ *đẩy con trỏ file của bạn*. Nếu bạn không biết con trỏ file là gì, hãy hiểu đơn giản rằng: nó đánh dấu vị trí bạn bắt đầu đọc. Để quay lại vị trí ban đầu, chúng ta dùng các hàm seek:
```julia
seekstart(io) # quay con trỏ file lên đầu
seek(io, i) # quay con trỏ file đến vị trí i
seekend(io) # đưa con trỏ file xuống vị trí cuối (eof)
```

{{< notice info >}}
Việc đọc file **không** phải do Julia xử lí, vị trí của con trỏ file cũng không giống với đánh chỉ số trong Julia. Nói cách khác, vị trí đầu tiên của con trỏ file là 0, không phải 1.
{{< /notice >}}

Để ghi một file, chúng ta phải mở file theo những chế đọc cho phép ghi (xem bảng trên). Sau đó:
```julia
write(io, "Hello world");
```

Việc ghi vào file không thực sự ghi vào ổ đĩa nơi chứa file, nó chỉ lưu vào một vùng đệm thôi. Việc ghi vào ổ đĩa sẽ xảy ra khi bạn đóng file.

{{< notice warning >}}
Hãy cẩn thận, nếu dùng chế độ `w` hoặc `w+`, file của bạn sẽ bị xóa sạch để ghi lại từ đầu.
{{< /notice >}}

Ngoài ra, trong một số trường hợp, bạn muốn đọc toàn bộ file hoặc ghi đè toàn bộ file, chúng ta có thể không cần mở, đóng file mà dùng trực tiếp `read` với `write` luôn:
```julia
read("tên file", String)
write("tên file", "Hello world")
```

### Ma trận

### Kiểu dữ liệu khác

## Làm việc với hệ thống file

## Tạm kết
