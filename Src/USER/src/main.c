#include "main.h"

#define START_STK_SIZE              256
#define START_TASK_PRIO             1
TaskHandle_t StartTask_Handler;

#define LED0_STK_SIZE               50
#define LED0_TASK_PRIO              2
TaskHandle_t Led0Task_Handler;

#define LED1_STK_SIZE               50
#define LED1_TASK_PRIO              3
TaskHandle_t Led1Task_Handler;

#define DEBUG_STK_SIZE              50
#define DEBUG_TASK_PRIO             6
TaskHandle_t DebugTask_Handler;

void led0_task(void *pvParmaeters)
{
    while(1)
    {
        GPIO_ResetBits(GPIOF, GPIO_Pin_9);
        vTaskDelay(500);
    }
}

void led1_task(void *pvParmaeters)
{
    while(1)
    {
        GPIO_ResetBits(GPIOF, GPIO_Pin_10);
        vTaskDelay(500);
        GPIO_SetBits(GPIOF, GPIO_Pin_10);
        vTaskDelay(500);
    }
}

void debug_task(void *pvParmaeters)
{
    while(1)
    {
        printf("hello Abit!\r\n");
        vTaskDelay(500);
    }
}

void start_task(void *pvParmaeters)
{
    taskENTER_CRITICAL();

    xTaskCreate((TaskFunction_t)led0_task,
                (const char *)"led0_task",
                (const configSTACK_DEPTH_TYPE)LED0_STK_SIZE,
                (void *)NULL,
                (UBaseType_t)LED0_TASK_PRIO,
                (TaskHandle_t)&Led0Task_Handler);

    xTaskCreate((TaskFunction_t)led1_task,
                (const char *)"led1_task",
                (const configSTACK_DEPTH_TYPE)LED1_STK_SIZE,
                (void *)NULL,
                (UBaseType_t)LED1_TASK_PRIO,
                (TaskHandle_t)&Led1Task_Handler);
    
    // xTaskCreate((TaskFunction_t)debug_task,
    //             (const char *)"deg_task",
    //             (const configSTACK_DEPTH_TYPE)DEBUG_STK_SIZE,
    //             (void *)NULL,
    //             (UBaseType_t)DEBUG_TASK_PRIO,
    //             (TaskHandle_t)&DebugTask_Handler);
    
    vTaskDelete(StartTask_Handler);
	taskEXIT_CRITICAL();
}

int main()
{
    bsp_abit_led_init();

    bsp_abit_usart_init(115200);

    bsp_abit_delay_init(168);

    xTaskCreate((TaskFunction_t)start_task,
                 (const char) "start_task",
                 (const configSTACK_DEPTH_TYPE)START_STK_SIZE,
                 (void *)NULL,
                 (UBaseType_t)START_TASK_PRIO,
                 (TaskHandle_t *)&StartTask_Handler);
    
    vTaskStartScheduler();

    return 0;
}