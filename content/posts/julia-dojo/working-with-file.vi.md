---
title: "Julia Dojo: làm việc với file"
date: 2020-02-08T20:41:06+07:00
draft: false
url: "/julia-dojo/lam-viec-voi-file-trong-julia"
summary: "Cách để lưu trữ dữ liệu từ Julia vào ổ đĩa, và nạp dữ liệu từ đĩa vào Julia"
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

## Lưu và nạp dữ liệu

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
Đừng lo lắng quá về các chế độ mở file. Theo mình, trong đa số trường hợp, bạn không cần quan tâm lắm về cái này.
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

Trong Julia thì có muôn vàn cách để đọc, ghi ma trận ra ổ cứng. Bạn có thể dùng file văn bản (CSV chẳng hạn), file Excel, file của Matlab, file của Python và thậm chí cả những định dạng riêng của Julia nữa.

Cách đơn giản nhất để lưu ma trận là một file văn bản. Julia cũng cấp một module tiêu chuẩn tên là `DelimitedFiles`, dùng để đọc và ghi những file dữ liệu được ngăn cách, chẳng hạn như file `mat.csv` dưới đây:
```text
3, 3.3, 1.0
0.8, 1.9, 3.2
```

Chúng ta dùng `DelimitedFiles` để đọc file trên thành ma trận một cách dễ dàng:
```julia
using DelimitedFiles
# đọc file mat.csv thành ma trận
# sử dụng dấu ',' để ngăn cách
# ép kiểu phần tử ma trận ra vào thành Float32
readdlm("mat.csv", ',', Float32)
```

Để ghi một ma trận ra file thay vì dùng "read", chúng ta dùng "write":
```julia
# Ma trận tạo ngẫu nhiên số phức cỡ 3 × 3
A = rand(ComplexF32, 3, 3)
# Ghi ma trận A ra file mat.txt
# dùng dấu ',' để ngăn cách
# mặt định là kí tự \t
writedlm("mat.txt", A, ',')
```

{{< notice info >}}
Sử dụng tên file sẽ ghi đè hoàn toàn file cũ. Nếu bạn muốn viết tiếp vào file hiện có, bạn có thể dùng lệnh `open` như ở trên với mode `"a"`, sau đó thay tên file trong những hàm trên bằng con trỏ file.
{{< /notice >}}

Ưu điểm của cách này là nó rất dễ, nhưng:
- cách này không lưu lại kiểu dữ liệu của ma trận (chẳng hạn mình có một ma trận nhưng ma trận này không chứa số)
- chậm: ví dụ chỉ lấy ma trận vuông kích cỡ 3 nên điều này không thể hiện rõ lắm.

Vậy chúng ta dùng cách nào để lưu? Cách đơn giản thứ 2 là dùng file `.npy` (file ma trận của Numpy). Để làm điều này chúng ta cần có gói `Pycall`. PyCall cung cấp giao diện giá đơn giản để chúng ta thao tác với Numpy.
```julia
# lôi thằng numpy ra
using PyCall
numpy = pyimport(numpy)
# tạo ma trận random
M = rand(10000, 10000)
# ghi và đọc file ma trận
numpy.save("mat.npy", M)
numpy.read("mat.npy")
```

Việc đọc/ghi file ma trận với ma trận M như trên sẽ chỉ mất khoảng 1 giây. Còn với DelimitedFiles chúng ta sẽ mất kha khá thơi gian. Nếu bạn cần đọc file `.csv` hãy dùng gói `CSV.jl` hoặc `DataFrames.jl`.

Ngoài ra, chúng ta có thể dùng file ma trận của Matlab với gói `MAT.jl`
```julia
using MAT
# mở file dữ liệu matlab
io = matopen("data.mat")
# tạo ma trận random, lưu vào file matlab
M = rand(10000, 10000)
# lưu biến Julia M vào thành biến matlab matM
write(io, "matM", M)
# hoặc
matwrite("data.mat", Dict("matM" => M); compress = true)
# đọc 1 biến từ file Matlab
names(io) # lấy ra những tên biến Matlab
M = read(io, "matM") # đọc biến matM trong file
# đọc tất cả biến Matlab
vars = matread("data.mat") # trả về một từ điển
```

### Lưu trữ vạn năng

Ở trên mình có nói chúng ta có thể lưu ma trận theo "định dạng riêng của Julia". Thực ra có một vài, không chỉ một định dạng, trong đó khá nổi bật là hai định dạng của `JuliaDB` và `JLD2`.

Cả hai định dạng file trên đều rất nhanh và tiện lợi để dùng. Không những lưu được số, chữ hay những kiểu dữ liệu nguyên thủy, hai anh này còn lưu được *gần như tất cả các loại dữ liệu trong Julia, kể cả dữ liệu người dùng định nghĩa*. 

{{< notice info >}}
`JuliaDB` thiên về lưu trữ cơ sở dữ liệu nhiều hơn (lưu các bảng dữ liệu), mình sẽ không nói thêm. Các bạn tự tìm hiểu nhé!
{{< /notice >}}

`JLD2` cung cấp hai macro để tiện lưu, nạp dữ liệu:
```julia
hello = "world"
foo = :bar
# lưu dữ liệu
@save "data.jld2" hello foo
@load "data.jld2" hello foo
```

Cách trên không tiện lắm vì chúng ta không đổi được tên của các biến được lưu hay nạp, đồng thời chúng ta cũng không thể ghi thêm hay gì khác. Thay vào đó, chúng ta có thể mở file `.jld2` và tạo con trỏ file như những loại file khác.
```julia
# lưu dữ liệu
# tạo file mới để ghi vào
jldopen("data.jld2", "w") do file
    # lưu giá trị "warudo" với nhãn "hello" trong file
    file["hello"] = "warudo"
    # hoặc
    write(file, "Hello", "warudo")
end
# nạp dữ liệu
za = jldopen("data.jld2") do file
    # in ra tên các "biến" có trong file
    @show keys(file)
    # nạp lại giá trị của nhãn "hello"
    read(file, "Hello")
    # hoặc
    file["hello"]
end
@show za 
```

Ngoài ra, có một gói mang tên `FileIO.jl`, gói này cung cấp giao diện để mở và làm việc kha khá nhiều loại file. `JLD2` cũng được hỗ trợ:
```julia
using FileIO
save("data.jld2", Dict("hello" => :friend))
goodbye = load("data.jld2", "hello")
```

Lưu ý rằng `FileIO` không trực tiếp mở file mà phải sử dụng một gói khác hỗ trợ. Bạn vẫn cần `JLD2` để làm việc với file `.jld2`.

Điều hay nhất của `JLD2` và `FileIO` là, khi bạn lưu, thông tin về kiểu dữ liệu của bạn cũng sẽ được lưu. Khi nạp lại để sử dụng, chúng ta không cần xử lí thêm về kiểu.

### Kiểu file dữ liệu khác

Ngoài ra chúng ta còn có những kiểu dữ liệu phức hợp khác được lưu dưới dạng file. Mình sẽ chỉ nêu tên gói, các bạn sẽ tự tìm hiểu nhé:

Kiểu dữ liệu | Các gói liên quan
---| ---
npy, pickle | `PyCall.jl`
XML | `EzXML.jl`, `XMLDict.jl`, `LightXML`
Excel | `ExcelFiles.jl`, `ExcelReaders.jl`
JSON | `JSON.jl`
BSON | `BSON.jl`
HDF5 | `HDF5.jl`
Một số file âm thanh | `LibSndFile.jl`, `MP3.jl`, `WAV.jl`
File ảnh | `Images.jl`
Arrow, Feather | `Feather.jl`, `Arrow.jl`

## Làm việc với hệ thống file
Các hệ điều hành thường sử dụng các hệ thống file các nhau. Cụ thể hơn, chúng ta thường phải quan tâm về cách tương tác vì chúng ta là người dùng. May thay, Julia cung cấp một giao diện chung để tương tác với hệ thống file khác nhau, giúp chúng ta tập trung vào những việc khác. Mình sẽ giới thiệu một số hàm mình nghĩ rằng hữu dụng.

Đường dẫn tới thư mục hiện tại.
```julia
pwd()
```

Đường dẫn tới thư mục/file tạm thời tương ứng với mỗi hệ điều hành. 
```julia
tempdir()
tempname()
```

Chuyển tới một thư mục.
```julia
cd("đường dẫn")
```

Ghép các đường dẫn, hàm này dùng để xử lý sự khác biệt giữa hệ thống file của Windows và *Nix. 
```julia
joinpath("dir", "subdir", "file")
# trả về "dir/subdir/file" trên *Nix (Linux, BSD...)
# trả về "dir\subdir\file" trên Windows
```

Tạo thư mục, `mkdir` sẽ tạo thư mục nếu tìm thấy các thư mục cha, còn mkpath sẽ tạo thư mục cha nếu không tìm thấy.
```julia
mkdir("đường dẫn")
mkpath("đường dẫn")
```

Đọc thư mục:
```julia
# lấy ra tất cả tên file
readdir("đường dẫn tới thư mục")
# lấy ra từng tên file một
for (root, dirs, files) in walkdir(".")
    println("Đường dẫn tới các thư mục $root")
    for dir in dirs
        println(joinpath(root, dir))
    end
    println("Các đường dẫn tới file trong $root")
    for file in files
        println(joinpath(root, file))
    end
end
```

Copy (`cp`), di chuyển (`mv`), xóa (`rm`) file:
```julia
cp("đường dẫn", "đường dẫn mới")
mv("đường dẫn cũ", "đường dẫn mới")
rm("đường dẫn")
```

Kiểm tra xem một đường dẫn có ứng với một file/thư mục/đường dẫn hay không:
```julia
isfile("xâu")
isdir("xâu")
ispath("xâu")
```

Thư mục của người dùng:
```julia
homedir()
```

Lấy ra đường dẫn thư mục, tên file từ dường dẫn:
```julia
dirname("/home/hung/") # trả về "/home/hung"
dirname("/home/hung") # trả về "/home"
basename("/tmp/something.jl") # trả về "something.jl"
```

## Tạm kết

Lúc đầu viết mình cũng không nghĩ bài sẽ dài như thế này. Tổng kết lại, chúng ta đã tìm hiểu về:
- Cách đọc, ghi file
- Lưu trữ tùy ý các kiểu dữ liệu của Julia
- Tương tác với hệ thống file thông qua Julia

Lưu ý thêm, nếu bạn sử dụng con trỏ file, đừng quên đóng file sau khi làm việc xong. Ngoài ra, với cú pháp `do`, con trỏ file được cho là local và file sẽ đóng ngay khi khối `do` chạy xong.

Tham khảo:
- https://docs.julialang.org/en/v1/base/file/#
- https://docs.julialang.org/en/v1/base/io-network/
- https://docs.julialang.org/en/v1/stdlib/DelimitedFiles
- https://github.com/JuliaIO/FileIO.jl
- https://github.com/JuliaIO/JLD2.jl
- https://github.com/JuliaIO/
