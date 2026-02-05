; ModuleID = 'loop_0.c'
source_filename = "loop_0.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: noreturn nounwind optsize
define hidden void @loop() local_unnamed_addr #0 {
  br label %1

1:                                                ; preds = %0, %1
  tail call void @foo() #2
  br label %1
}

; Function Attrs: optsize
declare void @foo() local_unnamed_addr #1

attributes #0 = { noreturn nounwind optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #1 = { optsize "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }
attributes #2 = { nounwind optsize }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.1.8 (Fedora 18.1.8-2.fc40)"}
