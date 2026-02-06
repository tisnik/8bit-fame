; ModuleID = 'simd_3.c'
source_filename = "simd_3.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef <16 x i8> @add(<16 x i8> noundef %0, <16 x i8> noundef %1) local_unnamed_addr #0 {
  %3 = add <16 x i8> %1, %0
  ret <16 x i8> %3
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext,+simd128" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.1.8 (Fedora 18.1.8-2.fc40)"}
