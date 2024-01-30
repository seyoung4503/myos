# myos
Make own OS

### 24.1.29
* Makefile 추가

### 24.1.30
* loader.s   
* printf 라이브러리 추가   
* Makefile GPP 옵션 추가    
>GPPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore   

>-m32 : 32bit 환경빌드   
>-fno-use-cxa-atexit : 메모리 관리 관련(옵션이 삭제되었을 수 있음)   
>-nostdlib : glibc 사용없이 빌드   
>-fno-builtin : 컴파일러에 의해 built-in코드로 대체되지 않음(사용자 정의 printf가 stdio.h에 정의된 printf 코드로 대체되지 않음)   
>-fno-rtti : runtime type information   
>-fno-exceptions : 예외 처리 비활성화   
>-fno-leading-underscore : 변수 앞 "_" 금지 옵션     

* linker script 작성
