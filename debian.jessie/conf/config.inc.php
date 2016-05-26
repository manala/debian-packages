<?php

/* Support additional configurations */
foreach (glob('/etc/phpmyadmin/conf.d/*.php') as $filename)
{
    include($filename);
}
