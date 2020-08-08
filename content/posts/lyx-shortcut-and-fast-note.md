---
title: "Phím tắt trong LyX & ghi chép tốc độ"
date: 2020-08-08T21:00:00+07:00
summary: "Phím tắt trong LyX và cách để ghi chép tốc độ cao"
draft: false
series:
- lyx
tags:
- linux
- foss
- lyx
- latex
- tex
- học online
- productivity
keywords:
- lyx
- ubuntu
- linux
- foss
- mã nguồn mở
- tự do
---

Có thể nói, LyX là một trong những nỗ lực của tác giả để thích nghi với việc học online, vì khi học online, việc ghi chép với vở trở nên rất lỉnh kỉnh do có nhiều công cụ trên bàn, hơn nữa một số giáo viên nói rất nhanh khi sử dụnng slide thay vì viết bảng. Tuy nhiên, dùng LyX với cả bàn phím và chuột sẽ không thể đạt được tốc độ tối đa. Do đó bài viết này sẽ cung cấp những thông tin cần thiết để làm việc với LyX chỉ bằng bàn phím (và có thể là một ít chuột). Đây có lẽ cũng là bài viết quan trọng nhất trong những bài về LyX.

Bài viết có thể khá dài nhưng chỉ có hai điều chủ yếu nên nhớ:
- Việc học thuộc phím tắt là hoàn toàn không cần thiết, cứ dùng một vài lần và *phím tắt sẽ thành phản xạ*.
- `Alt - p` cho đoạn văn (paragraph), `Alt - m` cho toán (math).

Hơn nữa, phần sau bài viết này đa phần mang tính giới thiệu. Phần đầu khá ngắn và cung cấp đủ thông tin về cách dùng phím tắt trong LyX.

## Sử dụng cơ bản

### Xem và cài đặt phím tắt

Như ở đầu bài viết nói, tất cả phím tắt có thể xem và tùy chỉnh trong `Tools > Preferences > Editing > Shortcuts`.

![Hình: shortcut](/img/lyx-shortcut-003.png)

Ở trên cùng, chúng ta có khung chọn bind file. Bind file là một file với đuôi `.bind` lưu preset cho phím tắt. Một số bind file được viết sẵn cho người dùng như `emacs`, `mac` (mặc định là `cue`). Những file này được lưu trong `/usr/share/lyx/bind/` (hoặc `/usr/local/share/lyx/bind`) trên \*Nix, `Lyx.app > show package > Contents/Library` (cần người test) và `C:\Program Files\LyX<phiên bản>\Resources\bind`.

Tiếp theo là dòng `show key-bindings containing`. Đây thực ra là một cái hộp textbox với bộ lọc để tìm phím tắt hiện có.

> Trong hình không nhìn thấy textbox vì màu nền của textbox trùng với màu nền cửa sổ. Hơi sida :v

Ở giữa, to nhất là bảng phím tắt. Bảng này được chia thành các mục lớn để dễ quản lý hơn. `Mathematical Symbols` (công thức toán) và `Font, Layout and Textclasses` (chỉnh sửa liên quan tới format văn bản) là hai mục chúng ta hay dùng nhất. `Cursor, Mouse and Editing functions` là những phím tắt liên quan tới điều hướng. `Document and Window` gồm những phím tắt điều khiển cửa sổ của LyX, đóng mở văn bản... `System and Miscellaneous` là những phím tắt không được xếp loại.

![Hình: shortcut](/img/lyx-shortcut-004.png)

Trong mỗi mục, các phím tắt có thể được sửa bằng cách nhấm đúp vào phím tắt hoặc chọn phím tắt và nhấn `Modify`. Hộp thoại nhỏ chính là phần để chỉnh sửa phím tắt.
- Function: là *câu lệnh của LyX* được gán cho phím tắt
- Shortcut: nhấn vào ô bên cạnh chữ shortcut và nhấm phím mình muốn để cài phím tắt
- Delete key: xóa một phím trong tổ hợp phím tắt
- Clear: xóa tất cả phím trong tổ hợp phím tắt
- Ok: lưu
- Cancel: hủy

Phím tắt mới có thể được thêm bằng nút `New`, hoặc xóa đi bằng phím `Remove`. Sau khi cài đặt xong. Cuối cùng, nút `Apply` hoặc `Ok` có thể dùng để lưu phím tắt khi cài đặt xong.

### Tìm câu lệnh & phím tắt của LyX

Để tạo ra phím tắt mới, chúng ta cần có thông tin về câu lệnh của LyX. Cách đơn giản nhất để tìm câu lệnh của LyX là dùng thử một vài phím tắt, sau đó tìm câu lệnh của những phím tắt đó trong phần cài đặt (Phần Function). Đối với những chức năng sử dụng menu, phím tắt được ghi:
- Ở bên phải của item trên menu.
- Được gạch chân

Menu trên thanh menu (bên dưới tiêu đề) có thể được truy cập bằng cách `Alt-<Phím tắt>`. Phím tắt được gạch chân ở tiêu đề menu và sẽ hiện khi nhấn giữ `Alt`.

Tuy nhiên, khi cần thêm một lệnh nào lạ lạ mà chúng ta không mò được bằng phím tắt, chúng ta cần cách khác. Đầu tiên, mở menu `View` và đảm bảo rằng `Messages pane` được bật. `Messages pane` chính là phần cửa sổ với tiêu đề (Progress/Debug Messages) chiếm nửa dưới màn hình.

![](/img/lyx-shortcut-005.png)

Tiếp theo, ở phần `Messages Pane`, chọn `Settings` và cài đặt như sau (xem thêm hình):
- Chọn `selected` ở phần `Debug Messages`
- Ở phần debug level, chuyển `action - User commands` thành `yes`.

![](/img/lyx-shortcut-006.png)

Sau đó, chuyển lại sang phần `Output` và khi một hành động được thực hiện. Câu lệnh của hành động đó sẽ hiện lên ở phần `Messages Pane` (phần bôi đen trong hình)

![](/img/lyx-shortcut-007.png)

Câu lệnh chính là phần trong ngoặc (`dialog show character`). Nó có thể được gắn với một phím tắt bằng cách thêm câu lệnh vào phần `Function` của phím tắt đó.

![](/img/lyx-shortcut-008.png)

### Sao lưu và khôi phục phím tắt

LyX lưu phím tắt người dùng thư mục tên `bind` trong đường dẫn như sau (`~` là thư mục home):
- Linux/Unix nói chung: `~/.lyx`
- MacOS: `~/Library/Application Support/LyX-<phiên bản>/` (chưa test)
- Windows: `C:\Documents and Settings\<tên người dùng>\Application Data\lyx<phiên bản>\`, `C:\Program files\lyx\resources\lyx\` (chưa test)

Chỉ cần lưu lại file bind và đặt nó vào đúng các thư mục trên là ok. 

> Ngoài ra, nếu không tìm thấy thư mục LyX thì có thể vào phần `Help > About LyX` trên menu. Phần này sẽ có cả thông tin về thư mục người dùng và hệ thống của LyX.

## Một số phím tắt hữu dụng

### Phím tắt thao túng môi trường

Nếu bạn không làm việc với toán hoặc các ký hiệu kỹ thuật (chỉ cần viết chữ), bạn có thể skip mục này.

> Từ "môi trường" chỉ là một từ bịa ra cho dễ nói thôi, không trực tiếp tương ứng với môi trường trong LaTeX, đừng lo về nó quá.

Trong LyX có ba loại môi trường mà chúng ta sẽ làm việc cùng:
- Môi trường văn bản: là môi trường mặc định mà chúng ta sử dụng. Vì nó là mặc định nên không cần insert.
- Môi trường toán: là môi trường mà chúng ta có thể nhét các lệnh trong môi trường toán của LaTeX vào. Đừng lo quá về chữ *toán*.
- E.R.T (evil red text): môi trường này cho phép sử dụng lệnh bất kì của LaTeX. Điểm khác biệt với môi trường toán là nó sẽ không có *preview mặc định* như môi trường toán; và lệnh nằm trong E.R.T tương ứng với môi trường bình thường của LaTeX (thay vì môi trường toán). Môi trường này có thể được insert bởi phím tắt `Ctrl-l`.

![](/img/lyx-shortcut-001.png)

#### Môi trường toán
Với môi trường toán, chúng ta có phím tắt cơ bản nhất là `Ctrl-m`, hoặc `Alt-m m` trong môi trường văn bản. Phím tắt này chèn một môi trường toán inline, môi trường này tương ứng với `$...$` trong LaTeX. Inline có nghĩa rằng trong văn bản cuối cùng phần toán sẽ nằm cùng với phần chữ.

Môi trường toán thứ hai là môi trường display, tương ứng với `$$...$$` trong LaTeX. Môi trường này tạo ra một dòng riêng cho phần toán. Môi trường display có thể được tạo ra với phím tắt `Alt-m d`. Nếu dùng `Alt-m d` một lần nữa trong môi trường display thì LyX sẽ chuyển lại môi trường inline.

Môi trường toán thứ ba là môi trường align, tương ứng với `\begin{align} \end{align}` trong LaTeX. Có hai cách để tạo môi trường Align, cách một là `Alt-i h a` trong môi trường text, cách hai là dùng tổ hợp `Alt-m t a` hoặc `Ctrl-Enter` trong môi trường toán. Môi trường align cũng tạo khu vực gồm nhiều dòng cho phần toán, các dòng được căn chỉnh để có một sự thẳng hàng nhất định (xem hình sẽ rõ).

![](/img/lyx-shortcut-002.png)

Các ô lẻ trong một dòng được căn lề trái, các ô chẵn căn lề phải. Môi trường align mặc định cung cấp còn có phím tắt để thêm dòng, cột:
- Thêm dòng sau dòng hiện tại: `Alt-m w i`
- Thêm cột sau cột hiện tại: `Alt-m c i`
- Xóa dòng hiện tại: `Alt-m w d`
- Xóa cột hiện tại: `Alt-m c d`
- Thêm dòng mới, nhưng chia nội dung dòng hiện tại ở vị trí con trỏ soạn thảo: `Ctrl-Enter`

> Cách để nhớ phím tắt dễ hơn: `w` tương ứng với dòng, `c` tương ứng với cột, `i` là insert (chèn thêm), `d` là delete (xóa).

LyX hỗ trợ việc lồng cái môi trường vào nhau. Để gõ chữ trong môi trường toán bất kì hãy dùng phím tắt `Ctrl-m` hoặc `Alt-m m`, LyX sẽ chèn một môi trường văn bản vào vị trí hiện tại. Ngoài những môi trường toán trên, LyX còn cung cấp những môi trường toán khác, nhưng chúng không hay được dùng lắm nên thường không có phím tắt *mặc định*. Những môi trường này có thể được sử dụng bằng cách nhấn chuột phải vào một môi trường toán và chọn `AMS Environment`.

### Phím tắt điều hướng

> Một số trong những phím tắt này, thực chất, là những phím tắt rất phổ biến, do đó không chỉ được dùng trong LyX, chúng được dùng trong khá nhiều các phần mềm khác mà có chứng năng soạn thảo (trình duyệt, hệ điều hành,...)

Phím tắt điều hướng chung
- `Trên/dưới/trái/phải`: Dịch con trỏ soạn thảo lên, xuống, trái, phải một cách tương ứng.
- `Ctrl-trái`/`Ctrl-phải`: Dịch chuyển con trỏ soạn thảo sang từ bên trái hoặc phải.
- `Home`/`End`: Dịch con trỏ soạn thảo về đầu/cuối dòng chữ.
- `Page up/down`: Cuộn lên, xuống với khoảng cách là độ dài màn hình.
- `Ctrl-Page up/down`: Chuyển sang văn bản phía trước/phía sau (nếu đang mở nhiều văn bản).
- `Ctrl-Home/End`: Nhảy xuống đầu/cuối văn bản.


Ngoài ra, chúng ta có một số phím tắt dùng trong môi trường toán:
> Lệnh ở phần này ám chỉ lệnh có dạng như trong LaTeX, ví dụ như `\lim`.
- `Tab`: Nếu đang viết dở một lệnh, `Tab` sẽ tự hoàn thành lệnh đó. Nếu có nhiều cách đề hoàn thành thì một bảng gợi ý sẽ hiện ra. Khi không viết lệnh nào, `Tab` được dùng để nhảy sang ô tiếp theo trong môi trường align (hoặc những môi trường có nhiều ô để viết). Nếu không có ô nào để nhảy thì nó sẽ thoát khỏi môi trường.
- `Shift-Tab`: Tương tự như `Tab` nhưng thay vì nhảy sang ô tiếp theo thì nhảy về ô ở phía trước.
- `Space`: Phím cách có tác dụng hoàn thành lệnh đang viết dở, nhưng `Space` sẽ *ngắt lệnh ngay lập tức thay vì tự điền lệnh*. Ngoài ra, `Space` có tác dụng thoát ra khỏi môi trường toán khi không viết lệnh.

Trong khi dùng những phím tắt điều hướng, phím `Shift` có thể được giữ để đánh dấu phần văn bản giũa hai vị trí con trỏ.

### Phím tắt chuyển layout
Trong LyX, mỗi đoạn văn đi kèm với một layout, layout có thể là:
- tiêu đề, section, subsection...
- đoạn văn bản
- liệt kê (đánh số hoặc không đánh số)
- đầu đoạn văn bản
- ...

Phím tắt `Alt-P` trong LyX liên kết tới *tất cả* các layout. Đầu tiên, các phím tắt từ `Alt-P-1` cho tới `Alt-P-5` được dùng cho các đề mục trong văn bản:
1. Chapter (chương)
2. Section (phần)
3. Subsection (phần con)
4. Subsubsection (phần cháu)
5. Paragraph (đầu đoạn văn)
Ngược lại với những layout đề mục, ta có `Alt-P-s` là layout mặc định, `s` là viết tắt của *standard* (tiêu chuẩn). Tiếp theo, chúng ta có:
- `Alt-P-t`: (`t` = title) tiêu đề cho cả văn bản
- `Alt-P-e` hoặc `Alt-P-n`: (`n` = numbered, `e` = enumerate) layout liệt kê có đánh số
- `Alt-P-b`: (`b` = bullet) layout liệt kê không đánh số

Còn nhiều phím tắt khác nhưng chúng sẽ không liệt kê ở đây mà để người đọc tự mò (dùng `Alt-P`). Với những layout không có phím tắt, sau khi sử dụng `Alt-P-Space`, một menu cho phép người dùng nhập keyword, LyX sẽ search keyword đó để tìm ra layout người dùng muốn (nhấn `Enter` để chọn, `Escape` để hủy, `Backspace` để xóa keyword).

### Phím tắt chèn

Phím tắt chèn có thể được xem trong menu insert, các phím tắt được gạch chân. Để mở menu insert, chúng ta cũng có phím tắt là `Alt-I`. Phím tắt cũng có thể được kết hợp với nhau. Ví dụ như `Alt-I H Y` sẽ chèn một ma trận. Trong môi trường toán `Alt-M` được dùng để chèn *gần như đủ mọi thứ*. Phần này người đọc được khuyên tự xem và tùy chỉnh phím tắt phù hợp ý mình. Tuy nhiên, vẫn có một số phím tắt toán thông dụng là:
- `Alt-M F`: \Frac - phân số
- `Alt-M S`: Square root - căn bậc 2
- `Alt-M R`: Root - căn bậc tùy ý
- `Alt-M <ngoặc>`: Chèn cặp ngoặc, mặc định áp dụng cho `()`, `{}`, `[]`, `||`, `<>`. phím tắt này được khuyên dùng thay vì dùng ngoặc đơn thuần. Lý do thứ nhất vì nó sẽ dùng `\left`, `\right` tự động để căn chỉnh độ rộng của ngoặc. Lý do thứ hai vì việc điều hướng dễ hơn. Cặp ngoặc chèn bởi phím tắt này sẽ tạo điểm neo cho phím tắt điều hướng.
- `Alt-M E`: Chèn chỉ số trên, được khuyên dùng thay cho `^`, vì tay sẽ phải với ít hơn và phím `6` rất khó bấm.
- `Alt-M X`: Chèn chỉ số dưới, được khuyên dùng thay cho `_` vì lý do tương tự.
- `Alt-M U`: Chèn dấu tổng

## Kết

Mới đầu, việc dùng phím tắt có thể hơi phức tạp và dài dòng nhưng sau đó, phím tắt sẽ boost tốc độ gõ lên rất, rất, rất nhiều. Lời khuyên thứ nhất là không nên học thuộc tất cả, chỉ cần sử dụng một vài lần với những chức năng thường dùng và tay sẽ quen với việc dùng phím tắt. Lời khuyên thứ hai là các phím tắt có tính gợi nhớ và thường là từ tiếng Anh nào đó. Mong rằng người đọc bài viết có thể làm việc hiệu quả với công cụ này.
