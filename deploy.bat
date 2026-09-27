@echo off
chcp 65001 > nul

REM 오늘 날짜를 MMDDSS 형식으로 가져오기 (월/일/초, 지역 설정과 무관)
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format MMddss"') do set STAMP=%%i
set MSG=블로그 글작성%STAMP%

echo 커밋 메시지: %MSG%
echo.

REM Hugo 빌드
hugo -t PaperMod

REM public 폴더 커밋 및 푸시
cd public
git add .
git commit -m "%MSG%"
git push origin main

REM 상위 폴더 커밋 및 푸시
cd ..
git add .
git commit -m "%MSG%"
git push origin main

echo.
echo 완료되었습니다.
pause