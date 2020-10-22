module external.core.types;

import freertos: TaskHandle_t;

alias ThreadID = TaskHandle_t;

immutable size_t PAGESIZE = 256;
