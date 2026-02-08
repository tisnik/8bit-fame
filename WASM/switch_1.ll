; ModuleID = 'switch_1.c'
source_filename = "switch_1.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: nounwind optsize
define hidden void @numeric_value(i32 noundef %0) local_unnamed_addr #0 {
  switch i32 %0, label %6 [
    i32 0, label %2
    i32 1, label %3
    i32 2, label %4
    i32 3, label %5
  ]

2:                                                ; preds = %1
  tail call void @foo() #2
  br label %6

3:                                                ; preds = %1
  tail call void @bar() #2
  br label %6

4:                                                ; preds = %1
  tail call void @baz() #2
  br label %6

5:                                                ; preds = %1
  tail call void @bzz() #2
  br label %6

6:                                                ; preds = %1, %5, %4, %3, %2
  ret void
}

; Function Attrs: optsize
declare void @foo() local_unnamed_addr #1

; Function Attrs: optsize
declare void @bar() local_unnamed_addr #1

; Function Attrs: optsize
declare void @baz() local_unnamed_addr #1

; Function Attrs: optsize
declare void @bzz() local_unnamed_addr #1

attributes #0 = { nounwind optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #1 = { optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #2 = { nounwind optsize }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.1.8 (Fedora 18.1.8-2.fc40)"}
