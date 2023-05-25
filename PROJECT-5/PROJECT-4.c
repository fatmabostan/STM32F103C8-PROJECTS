#include "stm32f10x.h"

//1- Buton iki saniye basili kalirsa ledi yakan ve 3 saniye sonra sonduren programi yaziniz. 
volatile unsigned int sayi=0;
void SysTick_Handler(){
sayi++;
}
int main() {
	//PortA 0.pinde buton bagli,Ledimiz de PC13
RCC->APB2ENR|=RCC_APB2ENR_IOPAEN|RCC_APB2ENR_IOPCEN; //PortA ve PortC enable
GPIOA->CRL&=~(GPIO_CRL_CNF0_0); //0000
GPIOA->CRL|=(GPIO_CRL_CNF1_1); //1000 0.pin input ayarlandi
GPIOA->ODR|=GPIO_ODR_ODR0; //0.pin pullup ayarlandi

GPIOC->CRH&=~(GPIO_CRH_CNF13_0); //PortC 13.pin 0000
GPIOC->CRH|=(GPIO_CRH_MODE13_1); //PortC 13.pin giris ayarlandi 0010
	
SysTick->LOAD=9000000; //snde 1kez sayar
SysTick->CTRL|=SysTick_CTRL_ENABLE | SysTick_CTRL_TICKINT; //Systick counter start, interrupt set edildi
	
while(1){
while(GPIOA->IDR & GPIO_IDR_IDR0){} //butona basilmadigi surece whileda bekle
sayi=0; //butona basildigi an sayi degiskeni baslar
while(!(GPIOA->IDR & GPIO_IDR_IDR0)) {} //butondan el cekilene kadar bekle
if(sayi==2)
{	
	GPIOC->ODR&=~GPIO_ODR_ODR13; //Led yandi 
	sayi=0;
	while(sayi<3) {} //sayi 3ten buyuk olana dek bekle
	GPIOC->ODR|=GPIO_ODR_ODR13; //3sn gectikten sonra led soner
}}}

//2- Butona basildiktan sonra 10 saniye icerisinde butona basilma sayisini sayan ve sonrasinda basilma sayisi kadar ledi yakip sonduren programi yaziniz.
int i;
volatile unsigned int sure=0;
volatile unsigned int basma=0;

int main(){
//buton PortA 0.pin, led PortC 13.pin
	RCC->APB2ENR|=RCC_APB2ENR_IOPAEN|RCC_APB2ENR_IOPCEN; //PortA ve PortC enable
GPIOA->CRL&=~(GPIO_CRL_CNF0_0); //0000
GPIOA->CRL|=(GPIO_CRL_CNF1_1); //1000 0.pin input ayarlandi
GPIOA->ODR|=GPIO_ODR_ODR0; //0.pin pullup ayarlandi

GPIOC->CRH&=~(GPIO_CRH_CNF13_0); //PortC 13.pin 0000
GPIOC->CRH|=(GPIO_CRH_MODE13_1); //PortC 13.pin giris ayarlandi 0010
	
SysTick->LOAD=9000000; //snde 1kez sayar
SysTick->CTRL|=SysTick_CTRL_ENABLE | SysTick_CTRL_TICKINT; //Systick counter start, interrupt set edildi
	
while(1)
{ while(GPIOA->IDR & GPIO_IDR_IDR0){} //butona basilmadigi surece whileda bekle
	sure=0; //butona basildigi an sayi degiskeni baslar
	while(sure<10 && !(GPIOA->IDR & GPIO_IDR_IDR0)) //Butona basilmis ve sure 10sden kucukse
	{	
		basma++; //basma degiskenini arttir.
		GPIOA->IDR|=GPIO_IDR_IDR0; //1kez basili tutmaya karsi bu onlemi aldim
		//Bu dusuncemin dogru olup olmadigina emin degilim, geri donut verirseniz anlayabilirim dogru mu yanlis mi
	}
	for(i=0; i<=basma; i++) //basilma sayisi kadar ledi yakip söndür
	{	
		GPIOC->ODR ^= (GPIO_ODR_ODR13); //Led yaniyorsa soner, sonukse yanar
	}
}
}