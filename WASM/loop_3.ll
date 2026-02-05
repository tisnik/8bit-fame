; ModuleID = 'loop_3.c'
source_filename = "loop_3.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: nofree norecurse nosync nounwind optsize memory(none)
define hidden i32 @loop(i32 noundef %0) local_unnamed_addr #0 {
  br label %2

2:                                                ; preds = %1, %2
  %3 = phi i32 [ %0, %1 ], [ %5, %2 ]
  %4 = phi i32 [ 0, %1 ], [ %6, %2 ]
  %5 = mul nsw i32 %3, 42
  %6 = add nuw nsw i32 %4, 1
  %7 = icmp eq i32 %6, 10
  br i1 %7, label %8, label %2, !llvm.loop !2

8:                                                ; preds = %2
  ret i32 %5
}

attributes #0 = { nofree norecurse nosync nounwind optsize memory(none) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.1.8 (Fedora 18.1.8-2.fc40)"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
