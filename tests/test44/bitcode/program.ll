; ModuleID = 'program.bc'
source_filename = "program.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [8 x i8] c"X: %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [8 x i8] c"Y: %ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [8 x i8] c"Z: %ld\0A\00", align 1
@.str.3 = private unnamed_addr constant [23 x i8] c"CAT invocations = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32, i8** nocapture readnone) local_unnamed_addr #0 {
  %3 = tail call i8* @CAT_new(i64 40) #3
  %4 = tail call i8* @CAT_new(i64 2) #3
  br label %8

; <label>:5:                                      ; preds = %8
  %6 = tail call i64 @CAT_invocations() #3
  %7 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.3, i64 0, i64 0), i64 %6)
  ret i32 0

; <label>:8:                                      ; preds = %8, %2
  %9 = phi i32 [ 1, %2 ], [ %17, %8 ]
  %10 = tail call i64 @CAT_get(i8* %3) #3
  %11 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i64 %10)
  %12 = tail call i64 @CAT_get(i8* %4) #3
  %13 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.1, i64 0, i64 0), i64 %12)
  %14 = tail call i8* @CAT_new(i64 0) #3
  tail call void @CAT_add(i8* %14, i8* %3, i8* %4) #3
  %15 = tail call i64 @CAT_get(i8* %14) #3
  %16 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i64 0, i64 0), i64 %15)
  tail call void @CAT_add(i8* %3, i8* %3, i8* %3) #3
  %17 = add nuw nsw i32 %9, 1
  %18 = icmp eq i32 %17, 6
  br i1 %18, label %5, label %8
}

declare dso_local i8* @CAT_new(i64) local_unnamed_addr #1

; Function Attrs: nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

declare dso_local i64 @CAT_get(i8*) local_unnamed_addr #1

declare dso_local void @CAT_add(i8*, i8*, i8*) local_unnamed_addr #1

declare dso_local i64 @CAT_invocations() local_unnamed_addr #1

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.0 (tags/RELEASE_800/final)"}
