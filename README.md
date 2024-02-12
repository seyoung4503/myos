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
   

### 24.2.07
* Makefile make clean 추가   
* printf 수정
> 이전의 32bit 컴퓨터(가령 도스)는 문자를 80 x 25 행 넣을 수 있었다. 이에 따라 printf를 수정함   
좋은 방법은 아니지만 문자를 화면에 다 채우면 화면을 초기화한다.   
> '\n' 문자열의 경우 줄바꿈 구현   

* IDT 추가   
> Interrupt Descriptor Table 정의   
> 키보드 인터럽트 등 여러 인터럽트시에 cpu에게 어디로 점프할 지 알려주는 테이블

uint8_t interrupt number    
void*   handler : RAM으로 점프할 주소   
        flags   
        segment : 프로세서가 세그먼트 영역을 바꿀때 (ex: user(code) -> kernel(handler)) 사용    
        accessright : 엑세스 권한(0:kernel space, 3: userspace)   

* 주의할 점: interrupt number는 어떤 함수의 파라미터로 사용할 수 없음.   
왜냐하면, 파라미터로 사용된다는 것은 cpu가 스택에다 push 해야 한다는 의미이고, cpu는 이 스택을 사용하는 것이 안전한 것인지 모르기 때문이다.   
   
* 해결법 : 모든 인터럽트에 대해서 어셈블러로 handler를 작성해주면 된다. 이 주솟값들은 cpu가 신뢰할 수 있고, loader.s에서 kernelMain으로 점프했던 것처럼 어셈블러에서 cpp 코드로 점프하도록 구현한다.   
이것을 어셈블러 매크로로 자동생성 될 수 있게 만든다.   
> nm interrupts.o 를 실행하여 컴파일러가 만든 인터럽트 핸들러 이름을 얻고, interruptstubs.s에 넣는다. 원한다면 extern "C"를 사용해서 프로그래머가 이름을 정해줄 수 있다.   

    
* interrupt 가 일어났음을 cpu에게 알려야 함   
> 하드웨어와 idt 초기화 이후 interrupt 실행   

### 24.2.10
gdt error 수정

### 24.2.12
* ActiveInterruptManager 추가 : 인터럽트 된 작업 확인
* Deactivate 함수 추가 : 인터럽트 끄는 함수
* DoHandleInterrupt 함수 추간
* timer interrupt 추가 (0x20)
* Keyboard driver 추가



