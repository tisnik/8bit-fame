; ModuleID = 'condition_3.c'
source_filename = "condition_3.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef float @foo(float noundef %0) local_unnamed_addr #0 {
  %2 = fcmp olt float %0, 1.000000e+01
  %3 = fadd float %0, 1.000000e+00
  %4 = fmul float %0, 3.000000e+00
  %5 = select i1 %2, float %3, float %4
  ret float %5
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.1.8 (Fedora 18.1.8-2.fc40)"}
