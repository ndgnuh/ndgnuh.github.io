---
title: "Julia Dojo: giới thiệu"
date: 2020-01-20T00:00:00+07:00
draft: false
summary: "Julia là cái gì?"
lastmod: 2020-01-25T21:42:58+07:00
tags:
- julia
- julia-dojo
keywords:
- julia
- lập trình
- ngôn ngữ julia
- julia dojo
- julialang
- hướng dẫn
---
## Julia?

Julia là một ngôn ngữ lập trình bậc cao dễ sử dụng, **nhanh** và mạnh mẽ. Một số đặc trưng của Julia cũng như lí do bạn sẽ muốn dùng nó (hoặc không):
- Julia là một ngôn ngữ lập trình hàm
- Kiểu động (dynamic typing)
- Julia được biên dịch (compile), tuy nhiên cũng có chế độ thông dịch (intepreter) nếu bạn muốn
- Julia **nhanh**
- Cú pháp rất dễ chịu, những bạn nào quen dùng `python` hoặc `matlab` sẽ thấy quen thuộc
- Cực kì mạnh, thư viện tiêu chuẩn hỗ trợ rất tốt việc tính toán toán học và xử lý song song.
- Multiple dispatch (cái này có thể khiến bạn cảm giác lạ lạ, nhưng nó đỉnh lắm)
- Julia miễn phí và mã nguồn mở (giấy phép MIT)
- Julia hứa hẹn sẽ giải quyết vấn đề hai ngôn ngữ

Khoan, nhiều "điểm tốt" quá, nghe vô lý. Thằng Python bậc cao nhưng nó chậm như rùa, mọi thư viện đều phải binding và viết với C. Thằng C thì nhanh, nhưng mà để viết được nó thì không phải ông nào cũng làm được. Thằng Matlab thì nhanh và dễ viết thật, nhưng bạn ơi, tiền đâu mà dùng Matlab, ngồi crack thôi chứ còn gì. Hơn nữa, Matlab nếu bạn dùng cho mục đích cá nhân thì crack được, chứ một tổ chức hay cơ quan thì họ sẽ bảo rằng: 
> Ở đây chúng tôi không làm vậy
> -- Họ không dùng Matlab ở Wakanda

Ok, mình vẫn chưa giải thích tại sao có nhiều "điểm tốt" như vậy. Julia đạt được những điều như trên vì 2 lí do:
- Julia dùng Just Intime Compiler (JIT)
- Việc biên dịch của Julia **cực kì phức tạp**, khiến cho mã Julia khi dịch xong có tốc độ [so sánh được với C hoặc Fortran](https://julialang.org/benchmarks/)

{{< img src="/img/julia-micro-benchmarks.png" label="Ảnh: Julia micro benchmark" caption="Micro benchmark theo thời gian chạy một số ngôn ngữ, thời gian chạy của C được lấy làm mốc. Các ngôn ngữ khác được so sánh tương đối.">}}

Đương nhiên, Julia cũng có khiếm khuyết, không có cái gì hoàn hảo cả. Và cộng đồng cũng rất cố gắng để cải thiện, xử lý chúng.
1. Cộng đồng Julia nhỏ một cách tương đối so với những "ông lớn" như Python, đặc biệt là cộng đồng người Việt. Mình cho rằng đây là vấn đề thời gian, và vấn đề này cũng là lí do mình ở đây, viết cái đống này cho các bạn :).
2. Mảng trong Julia *đánh chỉ số từ 1*. Có thể bạn đang nghĩ rằng sẽ dừng đọc và drop cái ngôn ngữ của nợ này ngay tại đây, hãy khoan đã. Theo mình thấy, vấn đề chỉ số này không ảnh hưởng nhiều lắm. Việc đánh chỉ số từ 0 được ông Dijikstra đưa ra và áp dụng trong kha khá ngôn ngữ lập trình, nhưng vẫn có những người dám phản dmg ông và đi theo trường phái khác. Cá nhân mình không có thành kiến gì với cả hai trường phái đâu, mình chỉ muốn nói **cả hai đều có thể dùng được**. Lí do duy nhất mình đưa cái này vào khuyết điểm vì có thể nó sẽ "dọa" những người mới.
> Tôi không biết bao nhiêu người trong số các ông đã đích thân gặp Dijikstra, nhưng các ông chắc đều biết rằng - sự kiêu ngạo trong tính toán khoa học được đo bằng nano-Dijikstra.
> -- Alan Kay (mình không biết ông này nhưng mà câu nói của ổng làm mình thấy khoái)
3. Lần đầu chạy code sẽ lâu hơn một chút. Ví dụ khi mình tạo random 100000 số kiểu double, lần đầu chạy `rand(Float64, 100000)` sẽ mất khoảng 0.06, những lần tiêp theo thời gian sẽ giảm đi còn 0.002 (nhanh gấp khoảng 30 lần). Có lẽ đây là vấn đề lớn nhất trong Julia. Nếu bạn hiểu JIT là cái gì, bạn sẽ thấy đặc điểm này gần như không thể tránh được. Tuy nhiên, với những người định "dùng thử" Julia, họ sẽ **trải nghiệm thời gian compile và tưởng nó là runtime**, sau đó sẽ nghĩ rằng "cái này không nhanh như quảng cáo". Điều này ảnh hưởng rất nhiều tới khuyết điểm số 1. Hiện tại, cộng đồng Julia đang rất ưu tiên giải quyết vấn đề này, họ đã tìm cách giảm thời gian compile đáng kể, đồng thời có cách để compile hoàn toàn mã nguồn Julia dưới dạng thư viện liên kết động.
4. Scala là cái tên được ghép từ "scalable" và "language". Swift mang nghĩa chuyển động trơn tru và tốc độ cao. Ruby là một viên đá quý. C++ là C tăng lên 1 level. C là kế tiếp của B. Matlab là viết tắt của Matrix Laboratory, thậm chí trong một ngôn ngữ nào đó, nó có nghĩa là sự thông thái... Vậy Julia cái tên Julia thì sao, nó có ý nghĩa gì?
> Đây là câu hỏi ưa thích của mọi người. Thực ra chả có lí do gì đâu, nghe cái tên nó hay hay.
> -- Stefan Karpinski =))

Huyên thuyên về Julia đủ rồi. Rất tiếc nếu mình không thuyết phục được bạn. Tuy nhiên, nếu bạn quyết định thử Julia và cho nó một cơ hội, hãy chuyển qua phần tiếp theo và bước vào [Julia Dojo](#julia-dojo).

## Julia Dojo

Vậy là bạn quyết định cho Julia một cơ hội, mình sẽ cảm ơn các bạn bằng một series hướng dẫn & thảo luận, mang tên "Julia Dojo". Series này sẽ tổng hợp từ rất nhiều nguồn kiến thức, nhưng chủ yếu mình sẽ lấy từ 3 nguồn:
- Tài liệu chính thức
- Julia Con (một hội thảo được tổ chức hàng năm)
- Hiểu biết của mình

Với tài liệu chính thức và Julia Con, bạn có thể xem một cách miễn phí trên mạng nếu nếu không ngại tiếng Anh; còn cái nguồn thứ ba, bạn có thể xem nếu bạn quen mình ngoài đời thực và có khả năng ngoại cảm.

Ý tưởng chính của Julia Dojo là: chúng ta sẽ train từng level một. Với mỗi level chúng ta sẽ đi sâu vào trong hệ thống của Julia hơn và thấy các thứ liên kết với nhau như thế nào. Trang này sẽ là nơi mình update các level của Dojo cùng với nội dung trong đó mỗi khi có bài mới.

### Level 1: nhập môn

- [Tải và cài đặt Julia](../julia-install.vi.md)

## Tạm kết

{{<notice note>}}
Fun fact: "Julia" nghe rất giống tên của một phụ nữ trong nhiều nền văn hóa, do đó, dù quy chuẩn của cộng đồng cho rằng Julia không dựa trên tên của ai và ngôn ngữ này không được nhân hóa dưới bất kì hình thức nào, một cơ số người khi nói về ngôn ngữ này vẫn vô thức dùng đại từ "cô ấy", trong đó có cả mình :))
{{</notice>}}

Ok, mình nghĩ đến đây là đủ cho bài giới thiệu. Chắc các bạn cũng đoán ra được rằng, mình đang muốn mở rộng cộng đồng người dùng Julia, cụ thể hơn là ở Việt Nam. Một lần nữa, nếu bạn quyết định cho Julia một cơ hội, mình xin cảm ơn. Mình sẽ cố viết post chất lượng và giải đáp thắc mắc của các bạn.

