# myos
Make own OS

### 24.1.29
* Makefile 추가

### 24.1.30
* loader.s 추가
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
> start_ctors, end_ctors : 구조체 선언   
> kernelMain 등 함수 앞 extern "C" 추가   

### 24.1.31
* Makefile mykernel.iso 부분 추가   
> iso : 이미지 파일   
   
* kernel.cpp CallConstructor() 함수 추가
> CallConstructor()는 start_ctors, end_ctors 사이에 실행된다.   

   
* My Operating System 첫 부팅 성공


### 24.2.02
* Makefile run 부분 추가   
이제 리눅스 커널 상에서 make run 시 파일이 모두 빌드되고, 가상머신에 올라간다.   
   
* type.h 추가   
> 하드웨어와 통신시 필요한 타입 정의   
> 일관적으로 kernel.cpp 함수 타입 수정 완료   

* Memory Segment 정의   
> 유저영역(Code, Data segment)과 kernel 영역을 구분함: 악성 코드가 특정 영역으로 점프하는 것을 방지한다.

* Global Descripter Table
> Starting point(Pointer in to the Ram)   
> length   
> flags   
entries : 8 byte   
    7   :             6            :         5         :         4        :        3 ,2       :     1, 0    
1 (Ptr) : 0.5 (flag) : 0.5 (limit) : 1 (Access Rights) : 1 (Expended Ptr) : 2 (Starting Ptr) : 2 (length)
   


* IDT 추가   
> Interrupt Descriptor Table 정의   
> 키보드 인터럽트 등 여러 인터럽트시에 cpu에게 어디로 점프할 지 알려주는 테이블
