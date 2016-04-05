<?php

/* Support additional configurations */
foreach (glob('/etc/phppgadmin/conf.d/*.php') as $filename)
{
    include($filename);
}
