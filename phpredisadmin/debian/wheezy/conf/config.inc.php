<?php

/* Support additional configurations */
foreach (glob('/etc/phpredisadmin/conf.d/*.php') as $filename)
{
    include($filename);
}
