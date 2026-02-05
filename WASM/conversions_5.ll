; ModuleID = 'conversions_5.c'
source_filename = "conversions_5.c"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32"

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef float @float_from_int(i32 noundef %0) local_unnamed_addr #0 {
  %2 = sitofp i32 %0 to float
  ret float %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef double @double_from_int(i32 noundef %0) local_unnamed_addr #0 {
  %2 = sitofp i32 %0 to double
  ret double %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef float @float_from_long(i64 noundef %0) local_unnamed_addr #0 {
  %2 = sitofp i64 %0 to float
  ret float %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef double @double_from_long(i64 noundef %0) local_unnamed_addr #0 {
  %2 = sitofp i64 %0 to double
  ret double %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef float @float_from_unsigned_int(i32 noundef %0) local_unnamed_addr #0 {
  %2 = uitofp i32 %0 to float
  ret float %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef double @double_from_unsigned_int(i32 noundef %0) local_unnamed_addr #0 {
  %2 = uitofp i32 %0 to double
  ret double %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef float @float_from_unsigned_long(i64 noundef %0) local_unnamed_addr #0 {
  %2 = uitofp i64 %0 to float
  ret float %2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none)
define hidden noundef double @double_from_unsigned_long(i64 noundef %0) local_unnamed_addr #0 {
  %2 = uitofp i64 %0 to double
  ret double %2
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind optsize willreturn memory(none) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+mutable-globals,+sign-ext" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 18.1.8 (Fedora 18.1.8-2.fc40)"}
