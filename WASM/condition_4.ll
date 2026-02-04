; ModuleID = 'condition_4.c'
source_filename = "condition_4.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: nounwind optsize
define hidden i32 @foo(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp slt i32 %0, 42
  br i1 %2, label %3, label %5

3:                                                ; preds = %1
  %4 = tail call i32 @bar(i32 noundef %0) #2
  br label %7

5:                                                ; preds = %1
  %6 = tail call i32 @baz(i32 noundef %0) #2
  br label %7

7:                                                ; preds = %5, %3
  %8 = phi i32 [ %4, %3 ], [ %6, %5 ]
  ret i32 %8
}

; Function Attrs: optsize
declare i32 @bar(i32 noundef) local_unnamed_addr #1

; Function Attrs: optsize
declare i32 @baz(i32 noundef) local_unnamed_addr #1

attributes #0 = { nounwind optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #1 = { optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #2 = { nounwind optsize }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.1.8 (Fedora 18.1.8-2.fc40)"}
