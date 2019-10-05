#include <R2T\nrf24L01.h>
#include <stdint.h>

#define nrf24_ADDR_LEN 5
#define nrf24_CONFIG ((1<<EN_CRC)|(0<<CRCO))

#define NRF24_TRANSMISSON_OK 0
#define NRF24_MESSAGE_LOST   1

/* adjustment functions */
void    nrf24_init();
void    nrf24_rx_address(char *adr);
void    nrf24_tx_address(char *adr);
void nrf24_config(char mode_tx1_rx0,char channel,char pay_length);

/* state check functions */
char nrf24_dataReady();
char nrf24_isSending();
char nrf24_getStatus();
char nrf24_rxFifoEmpty();

/* core TX / RX functions */
void    nrf24_send(char *value);
void    nrf24_getData(char *data);

/* use in dynamic length mode */
char nrf24_payloadLength();

/* post transmission analysis */
char nrf24_lastMessageStatus();
char nrf24_retransmissionCount();

/* Returns the payload length */
char nrf24_payload_length();

/* power management */
void    nrf24_powerUpRx();
void    nrf24_powerUpTx();
void    nrf24_powerDown();

/* low level interface ... */
void    nrf24_transmitSync(char *dataout,char len);
void    nrf24_transferSync(char *dataout,char *datain,char len);
void    nrf24_configRegister(char reg, char value);
void    nrf24_readRegister(char reg, char *value, char len);
void    nrf24_writeRegister(char reg, char *value, char len);