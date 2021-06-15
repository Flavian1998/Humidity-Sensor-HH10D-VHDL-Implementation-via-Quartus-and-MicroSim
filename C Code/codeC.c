#include <18F4550.h>    vérifier que c'est dispo dans le truc

#fuses NOWDT, HS, NOPUT, NOPROTECT, NOBROWNOUT, NOLVP, NOCPD, NOWRT, NODEBUG
#use delay(clock=20M)
#use i2c(master, sda=PIN_C4, scl=PIN_C3)

#include "LCD420_S3.c"


freq = freq/768 //pour être sur une valeur de référence


signed int16 lecdb_i2c(byte device, byte address, byte del) {
   BYTE dataM,dataL;
   int16 data;

   i2c_start();
   i2c_write(device);
   i2c_write(address);
   if (del!=0) delay_ms(del);
   i2c_start();
   i2c_write(device | 1);
   dataM = i2c_read(1);				// Read MSB
   dataL = i2c_read(0);				// Read LSB
   i2c_stop();
   data=((dataM*256)+dataL);		// True value
   return(data);
}

ong us2hz(long time) {				// conversion us en Hz
	float freq;

	freq=(float)1/time;
	return(freq*1E6);
}

float lecture_HH10D() {
		int16 freq,sens,offset=0;
		float humidity;

		freq=us2hz(pulse_width);			// Mesure de la frequence
		sens=lecdb_i2c(HH10D,0x0A,0);		// lecture de la sensibilit�
		offset=lecdb_i2c(HH10D,0x0C,0);		// lecture de l'offset

		// Formule du capteur d'humidit� HH10D
		// RH(%) = (offset-Freq)*sens/2^12
    	humidity = offset - freq;
    	humidity *= sens;
    	humidity /= 4096.0;
		return(humidity);
}

void flash_led(){

	output_high(led);
	delay_ms(20);
	output_low(led);
	delay_ms(20);
}

void initialisation() {

 	setup_ccp1(CCP_CAPTURE_RE);    // Configure CCP1 to capture rise
   	setup_ccp2(CCP_CAPTURE_FE);    // Configure CCP2 to capture fall
   	setup_timer_1(T1_INTERNAL);    // Start timer 1

	lcd_init();
	cursor(0);
	lcd_putc("\fMesure Humidite");
	lcd_putc("\n(C) UMONS - 2013");
	delay_ms(1500);

   	enable_interrupts(INT_CCP2);   // Setup interrupt on falling edge
   	enable_interrupts(GLOBAL);
}

void main()
{

	initialisation();

   	while(TRUE) {
    	delay_ms(800);
		printf(lcd_putc,"\fFreq: %lu Hz ",us2hz(pulse_width));
		printf(lcd_putc,"\nHumi: %g ", lecture_HH10D());
		lcd_putc("%  ");
		flash_led();
   }
}
