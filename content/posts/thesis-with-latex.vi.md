---
title: "Đồ án, luận văn với LaTeX"
date: 2021-06-16T03:10:11+07:00
summary: "Đánh lộn với quy định khi làm đồ án, luận văn dùng LaTeX"
tags:
series:
keywords:
- LaTeX
- BibLaTeX
- Thesis
- Đồ án
- Luận văn
- Cử nhân
- Thạc sĩ
- Tiến sĩ
- Bảo vệ
- Words
- Office
- Báo cáo
---

Gần một năm qua công việc ngập đầu, hậu quả là trang này chẳng có bài nào mới cả. Giờ bỏ được chút thời gian để ngồi viết, làm một bài nhẹ nhàng về LaTeX vậy. Chắc người nào nhấn vào đọc bài này thì cũng biết LaTeX rồi. LaTeX viết chỉnh chu và chuyên nghiệp, nhưng mà hệ thống các gói của nó rộng vô biên.

> Trường đại học mà tôi đang theo học---cứ gọi là trường H đi---là con chiên của Microsoft. Đồ gì của Microsoft cũng dùng, đương nhiên có cả office. Những biểu mẫu như đồ án, luận văn chỉ có trên Word, mặc dù không cấm dùng LaTeX.

Nếu viết một bài báo khoa học, có mẫu LaTeX sẵn thì thích rồi. Nhưng đối mặt với những tình huống như trường H, làm thể nào để nào để có thể viết một bài báo cáo chỉnh chu bằng LaTeX mà vẫn theo đúng quy định? Bài viết sẽ dùng mẫu đồ án của trường H (đúng hơn là viện S của trường H) làm ví dụ và cài đặt LaTeX theo. Do đó bài viết có thể mang tính kinh nghiệm hơn lý thuyết, tuy nhiên vẫn sẽ được viết tổng quát nhất có thể.

Yêu cầu để đọc hiểu bài này gồm cách dùng [LaTeX cơ bản](https://www.google.com/search?client=firefox-b-d&q=d%C3%B9ng+latex+c%C6%A1+b%E1%BA%A3n) và cách [viết file tài liệu tham khảo](https://nhdien.wordpress.com/2009/06/02/tai-li%E1%BB%87u-tham-kh%E1%BA%A3o-bibtex-trong-vietex/) (`.bib`).

## Chế bản

> - Đồ án được in trên một mặt giấy trắng khổ A4, sử dụng font chữ Times New Roman cỡ 13 hoặc 14.
> - Dãn dòng ở chế độ 1,5 line; lề trên 3,5 cm; lề dưới 3 cm; lề trái 3,5 cm; lề phải 2 cm. Số trang được đánh ở giữa, phía trên đầu hoặc cuối mỗi trang giấy.

Những yêu cầu này khá đơn giản. LaTeX đặt số trang ở giữa nên không có gì phải lo lắng. Việc đặt trên đầu hay cuối trang có thể dùng gói `fancyhdr` để chỉnh. Khổ giấy và lề trang được cài đặt bằng gói `geometry`.
```latex
\usepackage[
    a4paper,
    left=3.5cm, % lề trái
    right=2cm, % lề phải
    bottom=3cm, % lề dưới
    top=3.5cm % lề trên
]{geometry}
```

Gói `geometry` có một option khác là `bindingoffset` để định ra khoảng cách cần khi đóng gáy quyển. Tuy nhiên cái lề bự tổ chảng 3.5cm kia khả năng cao đã tính tới chuyện này rồi, do đó option này không cần thiết.

Khoảng cách dòng được cài đặt với gói `setspace` (khuyên dùng) hoặc định nghĩa lại `\baselinestretch`.
```latex
\usepackage{setspace}
\setstretch{1.5}
% 
\renewcommand{\baselinestretch}{1.5}
```
Đọc trên mạng hoặc xem trong tùy chọn của LyX có thể sẽ có một lựa chọn là `onehalf`, hay `\onehalfspacing`. Cái này **không** phải giãn dòng 1.5.

> Theo tôi thì `\onehalfspacing` đẹp hơn 1.5, vừa đủ để khoảng cách dòng đều nhau khi có các công thức toán. Người nào không để ý cũng khó mà phát hiện ra 1.5 hay one half.

Cuối cùng, font chữ Times New Roman là một font có bản quyền, và trong LaTeX vốn **không có** Times New Roman. Có một font gần với Times New Roman là Times Roman. Font được dùng khi thêm gói `mathptmx`.
```latex
\usepackage{mathptpx}
```
Lưu ý không dùng gói `times`. Gói này đã bị khai tử và sẽ làm cho font toán tệ không ngửi được. Để cài kích cỡ font, ta thêm `14pt` vào option của lệnh `\documentclass`
```latex
\documentclass[14pt]{extreport}
```
Gói `report` không hỗ trợ font 14 (theo tôi nhớ), do đó để có font cỡ 14 cần dùng `extreport`. Ngoài ra còn có class KOMA script report. Class này sẽ hỗ trợ nhiều cỡ font chữ.
```
\documentclass[13pt]{scrreport}
\documentclass[fontsize=13pt]{scrreport} # Nếu có warning về option bị khai tử
```

> Cá nhân tôi không recommend dùng hai font Times, vì nó không phải phần mềm tự do. Hơn nữa, tôi không nghĩ những người ngồi đọc đồ án có đôi mắt đủ tinh và cả thời gian để ngồi soi ra sự khác biệt giữa các font. Một bộ font khá tốt mới xuất hiện gần đây là `mlmodern`. Đây là bản thiết kế lại của font Latin Modern Roman (là thiết kế lại của Computer Modern, nếu tôi không nhầm). Font `mlmodern` sửa lại vấn đề bị mảnh quá mức của font Latin Modern Roman, thực sự nhìn nó rất "ngon". Để dùng font này chỉ cần load gói `mlmodern` là xong. Với người dùng LuaLaTeX hoặc XeLaTeX, tôi khuyên dùng Linux Libertine vì đây là một font với giấy phép tự do, được thiết kế để thay thế Times New Roman. PdfLaTeX cũng có Linux Libertine là chỉ có font T1, do đó không hỗ trợ tiếng Việt.


### Dùng LuaLaTeX/XeLaTeX

Không giống pdfLaTeX, XeLaTeX và LuaLaTeX hỗ trợ font định dạng `.otf` và `.ttf` (có thể nói là những định dạng font phổ biến). Do đó việc dùng Times New Roman hay những font khác hoàn toàn khả thi. Gói cần thiết để làm việc này là `spec`.
```latex
\usepackage{fontspec}
\setmainfont[SizeFeatures={Size=14}]{Times New Roman}
% Hoặc Libertine (https://www.dafont.com/linux-libertine.font)
% Sau khi giải nén, hãy đổi tên những font cần dùng, thay dấu _ bằng -
% Path không cần lắm, mặc định sẽ tự tìm trong hệ thống và thư mục hiện tại
% Dấu * sẽ được thay bởi LinLibertine (phần trong ngoặc {})
\setmainfont[SizeFeatures={Size=14}]{LinLibertine}{
    Path = ./, 
    Extension = .ttf,
    UprightFont = *-R,
    BoldFont = *-RB,
    ItalicFont = *-RI,
    BoldItalicFont = *-RZI,
}
```

## Tài liệu tham khảo

Đây có thể nói là phần khó nhằn nhất. Một phần vì BiBTeX dùng file `.bst` để xử lý việc format, sắp xếp tài liệu tham khảo. File `.bst` lại là một một ngữ stack dùng biểu thức hậu tố, cực kỳ khó viết nếu không quen với việc lập trình. Ngoài ra, BiBTeX cũng đã cũ và không hỗ trợ tiếng Việt (hay unicode bất kỳ). Một phần do cái mớ BiBLaTeX và BiBTeX khá bừa bộn.

Với các tạp chí khoa học, file `.bst` thường được làm sẵn. Tuy nhiên, như đã trình bày ở trên, trường H chỉ dùng đồ của Microsoft, do đó ta không thể đòi hỏi file `.bst`. Trước đây tôi cũng thử viết thủ công một file `.bst` tùy chỉnh, vừa khó vừa không hiệu quả. Những ai muốn thử có thể xem tài liệu [Tame the BeaST](http://tug.ctan.org/info/bibtex/tamethebeast/ttb_en.pdf) và công cụ `makebst`

Để phân biệt, BiBTeX là một công cụ khá cũ. Khi comiple file LaTeX, một file có đuôi `.aux` sẽ được tạo ra. Nếu trong file `tex` có lệnh `\bibliography` và `\cite`, những thông tin đó được lưu vào file `.aux`. File này được đưa vào lệnh `bibtex` để tạo ra một vài file phụ khác. Khi compile file LaTeX một lần nữa thì các tài liệu tham khảo sẽ xuất hiện chính xác. Vậy tạo một văn bản với BiBTeX cần ba bước:
```latex
pdflatex main.tex
bibtex main
pdflatex main.tex
```

BiBLaTeX thì không phải là công cụ dòng lệnh mà là một gói. Với BiBLaTeX ta có lệnh `biber` thay cho `bibtex`. BiBLaTeX hiện đại hơn, đủ mạnh để thực hiện các chức năng của file `.bst`, hỗ trợ unicode. Nhưng việc giao diện người dùng của nó khác với BiBTeX và có khá nhiều thứ để xem xét.

Khi làm đồ án, tôi xin một số file nguồn đồ án của các tiền bối, xem họ xử lý vấn đề này như thế nào. "Giải pháp" mà tôi tìm được trong các file đó là... chẳng dùng cái gì cả. Các tài liệu được viết chay từng `\bibitem` một. Làm như vậy vừa mất công sắp xếp bằng tay, vừa có thể gây nhầm lần, và đặc biệt với những ai chuyển từ paper sang đồ án thì đúng là ác mộng vì paper thường có một đống tài liệu tham khảo.

Nếu không viết chay, không dùng BiBTeX thì giải pháp còn lại của chúng ta đương nhiên chỉ có BiBLaTeX. Một cách lý thuyết, BiBLaTeX đủ mạnh để hỗ trợ những yêu cầu về tài liệu tham khảo của trường H (và cả những trường khác luôn :D).

### BiBLaTeX cơ bản

Để dùng BiBLaTeX, chúng ta cần import gói `biblatex`
```latex
\usepackage{biblatex}
```

BiBLaTeX cơ bản có hai lệnh:
```latex
\addbibliographysource{file}
\printbibliography[]
```

Lệnh đầu tiên dùng để thêm file `.bib` vào trong tài liệu. Lệnh thứ hai dùng để in ra các tài liệu tham khảo đã cite.
Cả hai lệnh này đều có thể sử dụng nhiều lần.

### Viết tên người đúng cách

Trong file `.bib`, viết tên người đúng cách rất quan trọng. Vì BiBLaTeX sẽ dựa vào đó để format tên và sắp xếp.
Trong bản ghi:
```bib
@article{dummy,
    title = {Abc},
    author = {Doe, Jane and Doe, John}
}
```
từ `and` được dùng để *ngăn cách giữa hai author* (không thay được bằng ngôn ngữ khác), dấu `,` được dùng để ngăn cách thành phần trong tên. Cấu trúc tên có dạng:
```
Họ đệm, Tên gọi
```

Trong ví dụ trên, Doe là họ và John/Jane là tên. Tuy nhiên, BiBLaTeX sẽ viết họ đệm trước, tên sau. Do đó, với tài liệu tiếng Việt, chúng ta viết ngược lại.
```bib
@misc{dummy,
    title = {Xàm ngôn},
    author = {Hùng, Nguyễn}
}
```

Làm như vậy không tối ưu lắm, vì có người sẽ phải sắp lại tài liệu tham khảo. BiBLaTeX chắc sẽ có chức năng để in tên theo thứ tự ngược lại.

> Nhưng tôi chưa nghiên cứu. Dùng tạm nhé.

### Sắp xếp tài liệu

> 1. Tài liệu tham khảo được xếp riêng theo từng ngôn ngữ (Việt, Anh, Pháp, Đức, Nga, Trung, Nhật...). Các tài liệu bằng tiếng nước ngoài phải giữ nguyên văn, không phiên âm, không dịch, kể cả tài liệu bằng tiếng Trung Quốc, Nhật... (đối với những tài liệu bằng ngôn ngữ còn ít người biết có thể thêm phần dịch tiếng Việt kèm theo mỗi tài liệu)
> 2. Tài liệu tham khảo xếp theo vần ABC.  Tài liệu không có tên tác giả thì xếp theo thứ tự ABC từ đầu của tên cơ quan ban hành báo cáo hay ấn phẩm, ví dụ: Tổng cục Thống kê xếp vào vần T, Bộ Giáo dục và Đào tạo xếp vào vần B…

Với yêu cầu xếp riêng từng ngôn ngữ, cách tốt nhất là sử dụng mỗi ngôn ngữ một file (tốt hơn so với ngồi ghi trường ngôn ngữ vào từng file một). Sau đó, bằng cách dùng `\DeclareSourceMap`---một lệnh của BiBLaTeX cho phép chỉnh sửa dữ liệu trong file `.bib`---ta thay đổi ngôn ngữ của các file tương ứng:
```latex
\DeclareSourcemap{
	\maps[datatype=bibtex, overwrite] {
		\map{
			\perdatasource{refs.bib}
			\step[fieldset=language, fieldvalue={02english}, append]
			\step[fieldset=keywords, fieldvalue={english}, append]
		}
		\map{
			\perdatasource{refs.vn.bib}
			\step[fieldset=language, fieldvalue={01vietnamese}, append]
			\step[fieldset=keywords, fieldvalue={vietnamese}, append]
		}
	}
}
```

Ở đây, file `refs.bib` là file tài liệu tiếng Anh. Lệnh `\step` được dùng để thêm trường `language` vào trong từng bản ghi của file này. Tương tự với `keywords` và file tiếng Việt.
```
\step[fieldset=language, fieldvalue={02english}, append]
\step[fieldset=keywords, fieldvalue={vietnamese}, append]
```

Để chia tài liệu tham khảo thành hai phần, ta chỉ cần in tài liệu tham khảo với những `keywords` ngôn ngữ tương ứng:
```
\printbibliography[
    heading=subbibliography,
    title={Tài liệu Tiếng Việt},
    keyword=vietnamese
]
\printbibliography[
    heading=subbibliography,
    title={Tài liệu Tiếng Anh}, 
    keyword=english
]
```

Để tài liệu tham khảo được sắp xếp theo ngôn ngữ, các trường language được thêm prefix thứ tự sắp xếp (`01vietnamese`, `02english`). Sau đó ta tiến hành định nghĩa cách sắp xếp theo các trường khác, sử dụng `\DeclareSortingTemplate` để định ra cách sắp xếp.
```latex
\DeclareSortingTemplate[]{oursort}{
	\sort{\field{language}}
	\sort{\field{sortname}\field{author}}
	\sort{\field{sorttitle}\field{title}}
}
```

Sau đó, đầu của văn bản sẽ dùng option `sorting` của `biblatex`:
```
\usepackage[sortcites,sorting=oursort]{biblatex}
```

Nếu tài liệu tham khảo vẫn chưa sắp theo ngôn ngữ, phần in tài liệu tham khảo có thể dùng môi trường `refcontext` như sau:
```latex
\begin{refcontext}[sorting=oursort]
\printbibliography[
    heading=subbibliography,
    title={Tài liệu Tiếng Việt},
    keyword=vietnamese
]
\printbibliography[
    heading=subbibliography,
    title={Tài liệu Tiếng Anh}, 
    keyword=english
]
\end{refcontext}
```

Tài liệu đã được sắp theo ngôn ngữ rồi, nhưng sắp xếp theo tên lại "sai". Lý do vì BiBLaTeX sắp theo tên họ thay vì tên gọi. Để thay đổi cách sắp xếp tên, ta dùng `\DeclareSortingNamekeyTemplate`:
```latex
\DeclareSortingNamekeyTemplate{
	\keypart{
		\namepart{given}
	}
	\keypart{
		\namepart{family}
	}
}
```
Trong đó `given` là tên gọi, `family` là họ đệm. Trong một số trường hợp hi hữu, tên sắp xếp sai vì chữ cái đầu có dấu, ta thêm `sortname` vào trong file `.bib` để BiBLaTeX sắp xếp đúng cách:
```bib
@article{Abc,
    author = {Trung, Đỗ Nam}, % Đỗ Nam Trung
    sortname = {Trung, Do Nam}
}
```

Giờ thì các tài liệu đã sắp xếp hẳn hoi, nhưng `language` (`01vietnamese`, `02english`) lại xuất hiện ở trong đó. Để ẩn `language` đi, ta sử dụng `\AtEveryBibitem` và `\clearlist`.
```latex
\AtEveryBibitem{%
	\clearlist{language}%
	\clearlist{keywords}%
}
```
Lưu ý: dấu `%` ở cuối rất quan trọng, nếu xuống dòng mà không thêm comment, LaTeX tự hiểu đó là dấu cách. Nếu muốn ẩn với những textual reference, thay vì dùng `\AtEveryBibitem` có thể dùng `\AtEveryCitekey`.

Cuối cùng, vì không có hỗ trợ tiếng Việt, những từ như `and`, `in` trong BiBLaTeX không được dịch, do đó ta thay luôn từ này bằng những thứ không phân biệt với các ngôn ngữ:
```latex
\renewbibmacro{in:}{} % bỏ luôn "in"
\renewcommand*{\finalnamedelim}{\addspace\&\addspace}% thay `and` bằng dấu &
```

### Format tài liệu

> 3. Tài liệu tham khảo là sách, luận án, báo cáo phải ghi đầy đủ các thông tin sau:
>   - Tên các tác giả hoặc cơ quan ban hành, 
>   - Tên sách, luận án hoặc báo cáo, (in nghiêng, dấu phẩy cuối tên)
>   - Nhà xuất bản, (dấu phẩy cuối tên nhà xuất bản)
>   - Nơi xuất bản,  Năm xuất bản (dấu chấm kết thúc tài liệu tham khảo)
>   Ví dụ:  3. Tống Đình Quỳ,  Giáo trình xác suất thống kê, Nhà xuất bản Giáo dục, Hà Nội, 2000.
> 4. Tài liệu tham khảo là Bài báo trong tạp chí, bài trong một cuốn sách ... ghi đầy đủ các thông tin sau:
>   - Tên các tác giả (dấu phẩy cuối tên)
>   - "Tên bài báo", (đặt trong ngoặc kép, không in nghiêng, dấu phẩy cuối tên)
>   - Tên tạp chí  hoặc tên sách,  (in nghiêng, dấy phẩy cuối tên)
>   - Tập (không có dấu ngăn cách); (Số), (dấu phẩy sau ngoặc đơn)
>   - Năm công bố (dấu phẩy) 
>   - Các số trang (gạch ngang giữa hai chữ số, dấu chấm kết thúc)
>   Ví dụ:  5. Nguyen Dinh Tri, “On a free boundary problem for the heat equation, Free boundary problems: theory and applications”, Research Notes in Math, Vol II, 1983, 397 – 406.

Để thay đổi format của một trường dữ liệu trong BiBLaTeX, ta dùng `\DeclareFieldFormat`:
```
\DeclareFieldFormat[inbook,suppbooksupplemental,bookinbook,booksingle,mvbook]{title}{\textit{#1}}
\DeclareFieldFormat[inbook,suppbooksupplemental,bookinbook,booksingle,mvbook]{publisher}{#1}
\DeclareFieldFormat[article,inproceedings]{title}{\mkbibquote{#1}}
\DeclareFieldFormat{pages}{#1}
\DeclareFieldFormat{volumes}{#1}
\DeclareFieldFormat{number}{#1}
\DeclareFieldFormat{month}{#1}
```

Phần ở trong ngoặc vuông là loại của tài liệu tham khảo (phần `@article` trong file `.bib`). Phần ngoặc nhọn đầu tiên là tên trường. Phần ngoặc nhọn thứ hai là cách format. Biểu tượng `#1` sẽ thay cho giá trị thực của trường.

Sau khi đã format các trường đúng cách, ta sắp xếp lại chúng bằng lệnh
```latex
\DeclareBibliographyDriver{loại tài liệu}{format}
```

Loại tài liệu giống với phần trong ngoặc vuông của `\DeclareFieldFormat`. Phần `format` sẽ dùng các lệnh sau:
- `\printnames{author}` in ra các trường dữ liệu có dạng tên người.
- `\addcomma` thêm dấu phẩy khi cần.
- `\addspace` thêm dấu cách khi cần.
- `\printfield{title}` in ra một trường đơn nào đó.
- `\finentry` kết thúc một mục tài liệu tham khảo.
- `\printlist` in ra một trường dữ liệu với nhiều giá trị (như `keywords`?)
- `\mkbibparens` thêm dấu ngoặc

Ngoài ra, với những trường giá trị không chắc chắn có, lệnh `\iffieldundef` được dùng để format có điều kiện:
```latex
\iffieldundef{volume}
    {}
    {\addcomma\addspace{}Vol \printfield{volume}}%
```

Dấu ngoặc đầu tiên là tên trường. Dấu thứ hai là thứ sẽ được in ra nếu trường đó không có gì. Dấu thứ ba là format bình thường.

Một format đầy đủ của `article` và `book` theo luật ở trên là:
```latex
% BOOK
\newcommand{\booklikebib}{%
	\printnames{author}
	\addcomma\addspace
	\printfield{title}
	\addcomma\addspace
	\printlist{publisher}
	\addcomma\addspace
	\printlist{location}
	\addcomma\addspace
	\printfield{year}
	\newunit\newblock
	\finentry
}
```

```latex
%ARTICLE
\newcommand{\articlelikebib}{%
	\printnames{author}
	\addcomma\addspace
	\printfield{title}
	\addcomma\addspace
	\printfield{journaltitle}
	\iffieldundef{volume}
		{}
		{\addcomma\addspace{}Vol \printfield{volume}}
	\iffieldundef{number}
		{}
		{\addsemicolon\addspace\mkbibparens{\printfield{number}}}
	\addcomma\addspace
	\printfield{year}
	\iffieldundef{pages}
		{}
		{\addcomma\addspace\printfield{pages}}
	\finentry
}
```

Ở đây, thay vì viết trực tiếp `\DeclareBibliographyDriver`, ta viết thành các lệnh với `\newcommand` để có thể thêm cùng một format vào các loại tài liệu khác nhau:
```
\DeclareBibliographyDriver{book}{\booklikebib}
\DeclareBibliographyDriver{inbook}{\booklikebib}
\DeclareBibliographyDriver{article}{\articlelikebib}
\DeclareBibliographyDriver{inproceedings}{\articlelikebib}
```

## Kết

Tôi rất rất khuyến nghị đọc tài liệu của BiBLaTeX. Có thể không cần đọc theo kiểu từ trên xuống dưới dâu, chỉ cần tìm những lệnh ở trên và tham khảo có lẽ cũng đủ dùng. Tài liệu của BiBLaTeX nằm ở https://ctan.org/pkg/biblatex?lang=en, chỉ cần kéo xuống dưới và nhấn vào "Package Documentation". Những ai có BiBLaTeX và `texdoc` trên máy có thể mở nhanh tài liệu bằng lệnh `texdoc biblatex`. Bản full của ví dụ tài liệu tham khảo nằm ở [đây](https://gist.github.com/ndgnuh/f6c235698a665702a585c8a4f9f4cd85), những ông ở viện S trường H dùng cái này trong đồ án luôn cũng được.

Với BiBLaTeX thì tôi cũng khuyên dùng LuaLaTeX. Nếu dùng pdfLaTeX thì BiBLaTeX sẽ kêu lỗi về encoding `utf8x`, phải chuyển về `utf8`; mà chuyển về `utf8` thì LaTeX sẽ phàn nàn một đống thứ về ký tự tiếng Việt.

Ngoài ra tài liệu [BiBLaTeX cheatsheet](http://tug.ctan.org/info/biblatex-cheatsheet/biblatex-cheatsheet.pdf) cũng được khuyến nghị vì nó ngắn gọn và liệt kê đủ các loại tài liệu tham khảo bên trong. Chúc anh chị em có mùa đồ án thành công và hết chật vật với báo cáo.
