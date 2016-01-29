// argument0: command
// argument1: instance

with (argument1) {
    switch (argument0) {
        case CMD_ACCELERATE: {
            speed += 1;
            break;
        }
        case CMD_BREAK: {
            speed -= 1;
            break;
        }
        case CMD_TURN_RIGHT: {
            direction -= 10;
            break;
        }
        case CMD_TURN_LEFT: {
            direction += 10;
            break;
        }
    }
}

