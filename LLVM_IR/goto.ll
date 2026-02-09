; ModuleID = 'goto.c'
source_filename = "goto.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-redhat-linux-gnu"

; Function Attrs: nounwind optsize uwtable
define dso_local void @bar(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp sgt i32 %0, 0
  br i1 %2, label %4, label %3

3:                                                ; preds = %1
  tail call void @positive_case() #2
  br label %5

4:                                                ; preds = %1
  tail call void @negative_case() #2
  br label %5

5:                                                ; preds = %4, %3
  tail call void @finish() #2
  ret void
}

; Function Attrs: optsize
declare dso_local void @positive_case() local_unnamed_addr #1

; Function Attrs: optsize
declare dso_local void @negative_case() local_unnamed_addr #1

; Function Attrs: optsize
declare dso_local void @finish() local_unnamed_addr #1

attributes #0 = { nounwind optsize uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind optsize }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{!"clang version 20.1.8 (Fedora 20.1.8-4.fc42)"}
