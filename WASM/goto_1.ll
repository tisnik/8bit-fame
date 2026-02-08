; ModuleID = 'goto_1.c'
source_filename = "goto_1.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: nounwind optsize
define hidden void @bar(i32 noundef %0) local_unnamed_addr #0 {
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
declare void @positive_case() local_unnamed_addr #1

; Function Attrs: optsize
declare void @negative_case() local_unnamed_addr #1

; Function Attrs: optsize
declare void @finish() local_unnamed_addr #1

attributes #0 = { nounwind optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #1 = { optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #2 = { nounwind optsize }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.1.8 (Fedora 18.1.8-2.fc40)"}
