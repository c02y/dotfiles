;; Object kernel/
;; SEMANTICDB Tags save file
(semanticdb-project-database-file "kernel/"
  :tables (list 
   (semanticdb-table "printk.c"
    :major-mode 'c-mode
    :tags 
        '( ("linux/kernel.h" include (:system-flag t) nil [646 671])
            ("linux/mm.h" include (:system-flag t) nil [672 693])
            ("linux/tty.h" include (:system-flag t) nil [694 716])
            ("linux/tty_driver.h" include (:system-flag t) nil [717 746])
            ("linux/console.h" include (:system-flag t) nil [747 773])
            ("linux/init.h" include (:system-flag t) nil [774 797])
            ("linux/jiffies.h" include (:system-flag t) nil [798 824])
            ("linux/nmi.h" include (:system-flag t) nil [825 847])
            ("linux/module.h" include (:system-flag t) nil [848 873])
            ("linux/moduleparam.h" include (:system-flag t) nil [874 904])
            ("linux/interrupt.h" include (:system-flag t) nil [905 933])
            ("linux/delay.h" include (:system-flag t) nil [961 985])
            ("linux/smp.h" include (:system-flag t) nil [986 1008])
            ("linux/security.h" include (:system-flag t) nil [1009 1036])
            ("linux/bootmem.h" include (:system-flag t) nil [1037 1063])
            ("linux/memblock.h" include (:system-flag t) nil [1064 1091])
            ("linux/syscalls.h" include (:system-flag t) nil [1092 1119])
            ("linux/kexec.h" include (:system-flag t) nil [1120 1144])
            ("linux/kdb.h" include (:system-flag t) nil [1145 1167])
            ("linux/ratelimit.h" include (:system-flag t) nil [1168 1196])
            ("linux/kmsg_dump.h" include (:system-flag t) nil [1197 1225])
            ("linux/syslog.h" include (:system-flag t) nil [1226 1251])
            ("linux/cpu.h" include (:system-flag t) nil [1252 1274])
            ("linux/notifier.h" include (:system-flag t) nil [1275 1302])
            ("linux/rculist.h" include (:system-flag t) nil [1303 1329])
            ("asm/uaccess.h" include (:system-flag t) nil [1331 1355])
            ("early_printk" function
               (:arguments 
                  ( ("fmt" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) [1449 1465])
                    ("..." variable (:type "vararg") (reparse-symbol arg-sub-list) [1466 1470]))                  
                :type ("asmlinkage" type (:type "class") nil nil))
                nil [1403 1474])
            ("__LOG_BUF_LEN" variable (:constant-flag t) nil [1484 1497])
            ("DEFAULT_MESSAGE_LOGLEVEL" variable (:constant-flag t) nil [1580 1604])
            ("MINIMUM_CONSOLE_LOGLEVEL" variable (:constant-flag t) nil [1706 1730])
            ("DEFAULT_CONSOLE_LOGLEVEL" variable (:constant-flag t) nil [1782 1806])
            ("DECLARE_WAIT_QUEUE_HEAD" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("log_wait" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [1878 1887]))                  
                :type "int")
                nil [1854 1888])
            ("console_printk" variable
               (:dereference 1
                :type "int")
                nil [1890 2142])
            ("oops_in_progress" variable (:type "int") nil [2274 2295])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("oops_in_progress" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [2310 2327]))                  
                :type "int")
                nil [2296 2328])
            ("DEFINE_SEMAPHORE" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type ("console_sem" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [2497 2509]))                  
                :type "int")
                nil [2473 2510])
            ("console_drivers" variable
               (:pointer 1
                :type ("console" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [2511 2543])
            ("EXPORT_SYMBOL_GPL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("console_drivers" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [2562 2578]))                  
                :type "int")
                nil [2544 2579])
            ("console_suspended" variable
               (:typemodifiers ("static")
                :type "int")
                nil [2943 2988])
            ("console_locked" variable
               (:typemodifiers ("static")
                :type "int")
                nil [2943 2988])
            ("DEFINE_SPINLOCK" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type ("logbuf_lock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [3188 3200]))                  
                :type "int")
                nil [3165 3201])
            ("LOG_BUF_MASK" variable (:constant-flag t) nil [3211 3223])
            ("LOG_BUF" variable (:constant-flag t) nil [3248 3255])
            ("log_start" variable
               (:typemodifiers ("static")
                :type "unsigned int")
                nil [3409 3435])
            ("con_start" variable
               (:typemodifiers ("static")
                :type "unsigned int")
                nil [3495 3521])
            ("log_end" variable
               (:typemodifiers ("static")
                :type "unsigned int")
                nil [3581 3605])
            ("exclusive_console" variable
               (:pointer 1
                :typemodifiers ("static")
                :type ("console" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [3751 3792])
            ("console_cmdline" type
               (:members 
                  ( ("name" variable
                       (:dereference 1
                        :type "char")
                        (reparse-symbol classsubparts) [3891 3904])
                    ("index" variable (:type "int") (reparse-symbol classsubparts) [3937 3947])
                    ("options" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol classsubparts) [3980 3994]))                  
                :type "struct")
                nil [3865 4127])
            ("MAX_CMDLINECONSOLES" variable (:constant-flag t) nil [4137 4156])
            ("console_cmdline" variable
               (:dereference 1
                :typemodifiers ("static")
                :type ("console_cmdline" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [4160 4227])
            ("selected_console" variable
               (:typemodifiers ("static")
                :type "int")
                nil [4228 4261])
            ("preferred_console" variable
               (:typemodifiers ("static")
                :type "int")
                nil [4262 4296])
            ("console_set_on_cmdline" variable (:type "int") nil [4297 4324])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("console_set_on_cmdline" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [4339 4362]))                  
                :type "int")
                nil [4325 4363])
            ("console_may_schedule" variable
               (:typemodifiers ("static")
                :type "int")
                nil [4410 4442])
            ("call_console_drivers" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("start" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [24408 24423])
                    ("end" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [24424 24437]))                  
                :type "void")
                nil [24375 24441])
            ("__add_preferred_console" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("name" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [24486 24497])
                    ("idx" variable (:type "int") (reparse-symbol arg-sub-list) [24498 24506])
                    ("options" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [24507 24521])
                    ("brl_options" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [24529 24547]))                  
                :type "int")
                nil [24451 25187])
            ("console_setup" function
               (:arguments 
                  ( ("str" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [25282 25292]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [25261 26365])
            ("__setup" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("console_setup" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [26386 26400]))                  
                :type "int")
                nil [26366 26401])
            ("add_preferred_console" function
               (:arguments 
                  ( ("name" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [26983 26994])
                    ("idx" variable (:type "int") (reparse-symbol arg-sub-list) [26995 27003])
                    ("options" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [27004 27018]))                  
                :type "int")
                nil [26957 27081])
            ("update_console_cmdline" function
               (:arguments 
                  ( ("name" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [27110 27121])
                    ("idx" variable (:type "int") (reparse-symbol arg-sub-list) [27122 27130])
                    ("name_new" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [27131 27146])
                    ("idx_new" variable (:type "int") (reparse-symbol arg-sub-list) [27147 27159])
                    ("options" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [27160 27174]))                  
                :type "int")
                nil [27083 27593])
            ("console_suspend_enabled" variable (:type "int") nil [27595 27627])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("console_suspend_enabled" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [27642 27666]))                  
                :type "int")
                nil [27628 27667])
            ("console_suspend_disable" function
               (:arguments 
                  ( ("str" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [27711 27721]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [27680 27766])
            ("__setup" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("console_suspend_disable" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [27797 27821]))                  
                :type "int")
                nil [27767 27822])
            ("suspend_console" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [27965 27970]))                  
                :type "void")
                nil [27944 28145])
            ("resume_console" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [28167 28172]))                  
                :type "void")
                nil [28147 28281])
            ("console_cpu_notify" function
               (:arguments 
                  ( ("self" variable
                       (:pointer 1
                        :type ("notifier_block" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [28739 28767])
                    ("action" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [28769 28790])
                    ("hcpu" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [28791 28802]))                  
                :type ("__cpuinit" type (:type "class") nil nil))
                nil [28710 28982])
            ("console_lock" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [29236 29241]))                  
                :type "void")
                nil [29218 29373])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("console_lock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [29388 29401]))                  
                :type "int")
                nil [29374 29402])
            ("console_trylock" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [29708 29713]))                  
                :type "int")
                nil [29688 29882])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("console_trylock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [29897 29913]))                  
                :type "int")
                nil [29883 29914])
            ("is_console_locked" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [29938 29943]))                  
                :type "int")
                nil [29916 29971])
            ("DEFINE_PER_CPU" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "int") (reparse-symbol arg-sub-list) [29995 29999])
                    ("" variable (:type ("printk_pending" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [30000 30015]))                  
                :type "int")
                nil [29973 30016])
            ("printk_tick" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [30035 30040]))                  
                :type "void")
                nil [30018 30162])
            ("printk_needs_cpu" function
               (:arguments 
                  ( ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [30185 30193]))                  
                :type "int")
                nil [30164 30281])
            ("wake_up_klogd" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [30302 30307]))                  
                :type "void")
                nil [30283 30382])
            ("console_unlock" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [30864 30869]))                  
                :type "void")
                nil [30844 31715])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("console_unlock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [31730 31745]))                  
                :type "int")
                nil [31716 31746])
            ("console_conditional_schedule" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [32032 32037]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [31995 32086])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("console_conditional_schedule" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [32101 32130]))                  
                :type "int")
                nil [32087 32131])
            ("console_unblank" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [32154 32159]))                  
                :type "void")
                nil [32133 32553])
            ("console_device" function
               (:pointer 1
                :arguments 
                  ( ("index" variable
                       (:pointer 1
                        :type "int")
                        (reparse-symbol arg-sub-list) [32664 32675]))                  
                :type ("tty_driver" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [32630 32900])
            ("console_stop" function
               (:arguments 
                  ( ("console" variable
                       (:pointer 1
                        :type ("console" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [33115 33139]))                  
                :type "void")
                nil [33097 33212])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("console_stop" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [33227 33240]))                  
                :type "int")
                nil [33213 33241])
            ("console_start" function
               (:arguments 
                  ( ("console" variable
                       (:pointer 1
                        :type ("console" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [33262 33286]))                  
                :type "void")
                nil [33243 33358])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("console_start" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [33373 33387]))                  
                :type "int")
                nil [33359 33388])
            ("keep_bootcon" variable (:type ("__read_mostly" type (:type "class") nil nil)) nil [33401 33428])
            ("keep_bootcon_setup" function
               (:arguments 
                  ( ("str" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [33467 33477]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [33441 33578])
            ("early_param" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("keep_bootcon_setup" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [33608 33627]))                  
                :type "int")
                nil [33580 33628])
            ("register_console" function
               (:arguments 
                  ( ("newcon" variable
                       (:pointer 1
                        :type ("console" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [34552 34575]))                  
                :type "void")
                nil [34530 38840])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("register_console" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [38855 38872]))                  
                :type "int")
                nil [38841 38873])
            ("unregister_console" function
               (:arguments 
                  ( ("console" variable
                       (:pointer 1
                        :type ("console" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [38898 38922]))                  
                :type "int")
                nil [38875 39668])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("unregister_console" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [39683 39702]))                  
                :type "int")
                nil [39669 39703])
            ("printk_late_init" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [39740 39745]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [39716 40012])
            ("late_initcall" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("printk_late_init" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [40027 40044]))                  
                :type "int")
                nil [40013 40045]))          
    :file "printk.c"
    :pointmax 43646
    :fsize 43645
    :lastmodtime '(21468 9214 850171 691000)
    :unmatched-syntax '((INT 39712 . 39715) (STATIC 39705 . 39711) (string 33592 . 33606) (INT 33437 . 33440) (STATIC 33430 . 33436) (INT 33397 . 33400) (STATIC 33390 . 33396) (VOID 31990 . 31994) (INT 28706 . 28709) (STATIC 28699 . 28705) (string 27775 . 27795) (INT 27676 . 27679) (STATIC 27669 . 27675) (string 26374 . 26384) (INT 25257 . 25260) (STATIC 25250 . 25256) (VOID 1398 . 1402))
    :lexical-table 
        '(("MINIMUM_CONSOLE_LOGLEVEL" . ((number "1" 1731 . 1732)))
          ("DEFAULT_CONSOLE_LOGLEVEL" . ((number "7" 1807 . 1808)))
          ("MAX_CMDLINECONSOLES" . ((number "8" 4157 . 4158)))
          ("__LOG_BUF_LEN" . ((semantic-list "(1 << CONFIG_LOG_BUF_SHIFT)" 1498 . 1525)))
          ("DEFAULT_MESSAGE_LOGLEVEL" . ((symbol "CONFIG_DEFAULT_MESSAGE_LOGLEVEL" 1605 . 1636)))
          ("LOG_BUF_MASK" . ((semantic-list "(log_buf_len-1)" 3224 . 3239)))
          ("LOG_BUF" (spp-arg-list ("idx") 3255 . 3260) . ((semantic-list "(log_buf[(idx) & LOG_BUF_MASK])" 3261 . 3292)))
          )

    )
   (semanticdb-table "watchdog.c"
    :major-mode 'c-mode
    :tags 
        '( ("linux/mm.h" include (:system-flag t) nil [458 479])
            ("linux/cpu.h" include (:system-flag t) nil [480 502])
            ("linux/nmi.h" include (:system-flag t) nil [503 525])
            ("linux/init.h" include (:system-flag t) nil [526 549])
            ("linux/delay.h" include (:system-flag t) nil [550 574])
            ("linux/freezer.h" include (:system-flag t) nil [575 601])
            ("linux/kthread.h" include (:system-flag t) nil [602 628])
            ("linux/lockdep.h" include (:system-flag t) nil [629 655])
            ("linux/notifier.h" include (:system-flag t) nil [656 683])
            ("linux/module.h" include (:system-flag t) nil [684 709])
            ("linux/sysctl.h" include (:system-flag t) nil [710 735])
            ("asm/irq_regs.h" include (:system-flag t) nil [737 762])
            ("linux/perf_event.h" include (:system-flag t) nil [763 792])
            ("watchdog_enabled" variable (:type "int") nil [794 819])
            ("watchdog_thresh" variable (:type ("__read_mostly" type (:type "class") nil nil)) nil [824 859])
            ("DEFINE_PER_CPU" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [883 897])
                    ("" variable (:type ("watchdog_touch_ts" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [898 916]))                  
                :type "int")
                nil [861 917])
            ("DEFINE_PER_CPU" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [940 961])
                    ("" variable (:type ("softlockup_watchdog" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [962 982]))                  
                :type "int")
                nil [918 983])
            ("DEFINE_PER_CPU" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type ("hrtimer" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol arg-sub-list) [1006 1021])
                    ("" variable (:type ("watchdog_hrtimer" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [1022 1039]))                  
                :type "int")
                nil [984 1040])
            ("DEFINE_PER_CPU" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "bool") (reparse-symbol arg-sub-list) [1063 1068])
                    ("" variable (:type ("softlockup_touch_sync" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [1069 1091]))                  
                :type "int")
                nil [1041 1092])
            ("DEFINE_PER_CPU" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "bool") (reparse-symbol arg-sub-list) [1115 1120])
                    ("" variable (:type ("soft_watchdog_warn" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [1121 1140]))                  
                :type "int")
                nil [1093 1141])
            ("softlockup_panic" variable (:type ("__read_mostly" type (:type "class") nil nil)) nil [1972 2048])
            ("softlockup_panic_setup" function
               (:arguments 
                  ( ("str" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [2091 2101]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [2061 2167])
            ("__setup" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("softlockup_panic_setup" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [2197 2220]))                  
                :type "int")
                nil [2168 2221])
            ("nowatchdog_setup" function
               (:arguments 
                  ( ("str" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [2258 2268]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [2234 2306])
            ("__setup" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("nowatchdog_setup" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [2329 2346]))                  
                :type "int")
                nil [2307 2347])
            ("nosoftlockup_setup" function
               (:arguments 
                  ( ("str" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [2403 2413]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [2377 2451])
            ("__setup" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("nosoftlockup_setup" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [2476 2495]))                  
                :type "int")
                nil [2452 2496])
            ("get_softlockup_thresh" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [2890 2895]))                  
                :type "int")
                nil [2857 2928])
            ("get_timestamp" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("this_cpu" variable (:type "int") (reparse-symbol arg-sub-list) [3124 3137]))                  
                :type "unsigned long")
                nil [3089 3198])
            ("get_sample_period" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [3239 3244]))                  
                :type "unsigned long")
                nil [3200 3479])
            ("__touch_watchdog" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [3552 3557]))                  
                :type "void")
                nil [3523 3661])
            ("touch_softlockup_watchdog" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [3694 3699]))                  
                :type "void")
                nil [3663 3744])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("touch_softlockup_watchdog" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [3759 3785]))                  
                :type "int")
                nil [3745 3786])
            ("touch_all_softlockup_watchdogs" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [3824 3829]))                  
                :type "void")
                nil [3788 4052])
            ("touch_softlockup_watchdog_sync" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [4405 4410]))                  
                :type "void")
                nil [4369 4507])
            ("is_softlockup" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("touch_ts" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [4839 4862]))                  
                :type "int")
                nil [4814 5057])
            ("watchdog_interrupt_count" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [6479 6484]))                  
                :type "void")
                nil [6435 6496])
            ("watchdog_timer_fn" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("hrtimer" variable
                       (:pointer 1
                        :type ("hrtimer" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [6616 6640]))                  
                :type ("hrtimer_restart" type (:type "enum") nil nil))
                nil [6570 8195])
            ("watchdog" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("unused" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [8273 8286]))                  
                :type "int")
                nil [8253 9180])
            ("watchdog_nmi_enable" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [10788 10796]))                  
                :type "int")
                nil [10757 10810])
            ("watchdog_nmi_disable" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [10844 10852]))                  
                :type "void")
                nil [10811 10864])
            ("watchdog_prepare_cpu" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [10977 10985]))                  
                :type "void")
                nil [10944 11194])
            ("watchdog_enable" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [11223 11231]))                  
                :type "int")
                nil [11196 11971])
            ("watchdog_disable" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [12002 12010]))                  
                :type "void")
                nil [11973 12426])
            ("watchdog_enable_all_cpus" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [12465 12470]))                  
                :type "void")
                nil [12428 12765])
            ("watchdog_disable_all_cpus" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [12805 12810]))                  
                :type "void")
                nil [12767 12976])
            ("cpu_callback" function
               (:arguments 
                  ( ("nfb" variable
                       (:pointer 1
                        :type ("notifier_block" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [13573 13600])
                    ("action" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [13601 13622])
                    ("hcpu" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [13623 13634]))                  
                :type ("__cpuinit" type (:type "class") nil nil))
                nil [13550 14296])
            ("cpu_nfb" variable (:type ("__cpuinitdata" type (:type "class") nil nil)) nil [14327 14386])
            ("lockup_detector_init" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [14421 14426]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [14393 14661]))          
    :file "watchdog.c"
    :pointmax 14662
    :fsize 14661
    :lastmodtime '(21468 9214 529179 291000)
    :unmatched-syntax '((VOID 14388 . 14392) (symbol 14312 . 14326) (STRUCT 14305 . 14311) (STATIC 14298 . 14304) (INT 13546 . 13549) (STATIC 13539 . 13545) (string 2460 . 2474) (INT 2373 . 2376) (STATIC 2366 . 2372) (string 2315 . 2327) (INT 2230 . 2233) (STATIC 2223 . 2229) (string 2176 . 2195) (INT 2057 . 2060) (STATIC 2050 . 2056) (INT 1968 . 1971) (UNSIGNED 1959 . 1967) (INT 820 . 823))
    )
   (semanticdb-table "smp.c"
    :major-mode 'c-mode
    :tags 
        '( ("linux/rcupdate.h" include (:system-flag t) nil [95 122])
            ("linux/rculist.h" include (:system-flag t) nil [123 149])
            ("linux/kernel.h" include (:system-flag t) nil [150 175])
            ("linux/module.h" include (:system-flag t) nil [176 201])
            ("linux/percpu.h" include (:system-flag t) nil [202 227])
            ("linux/init.h" include (:system-flag t) nil [228 251])
            ("linux/gfp.h" include (:system-flag t) nil [252 274])
            ("linux/smp.h" include (:system-flag t) nil [275 297])
            ("linux/cpu.h" include (:system-flag t) nil [298 320])
            ("setup_max_cpus" variable (:type "unsigned int") nil [16662 16700])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("setup_max_cpus" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [16715 16730]))                  
                :type "int")
                nil [16701 16731])
            ("arch_disable_smp_support" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [17124 17129]))                  
                :type ("__weak" type (:type "class") nil nil))
                nil [17092 17133])
            ("nosmp" function
               (:arguments 
                  ( ("str" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [17159 17169]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [17146 17235])
            ("early_param" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("nosmp" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [17258 17264]))                  
                :type "int")
                nil [17237 17265])
            ("nrcpus" function
               (:arguments 
                  ( ("str" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [17317 17327]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [17303 17453])
            ("early_param" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("nrcpus" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [17478 17485]))                  
                :type "int")
                nil [17455 17486])
            ("maxcpus" function
               (:arguments 
                  ( ("str" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [17514 17524]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [17499 17632])
            ("early_param" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("maxcpus" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [17657 17665]))                  
                :type "int")
                nil [17634 17666])
            ("__read_mostly" variable (:type ("nr_cpu_ids" type (:type "class") nil nil)) nil [17717 17752])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("nr_cpu_ids" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [17767 17778]))                  
                :type "int")
                nil [17753 17779])
            ("setup_nr_cpu_ids" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [17889 17894]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [17865 17972])
            ("smp_init" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [18048 18053]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [18032 18380])
            ("on_each_cpu" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [18588 18600])
                    ("info" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [18615 18626])
                    ("wait" variable (:type "int") (reparse-symbol arg-sub-list) [18627 18636]))                  
                :type "int")
                nil [18572 18837])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("on_each_cpu" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [18852 18864]))                  
                :type "int")
                nil [18838 18865]))          
    :file "smp.c"
    :pointmax 18866
    :fsize 18865
    :lastmodtime '(21468 9213 115212 768000)
    :unmatched-syntax '((semantic-list 18601 . 18613) (semantic-list 18593 . 18600) (VOID 18027 . 18031) (VOID 17860 . 17864) (INT 17713 . 17716) (string 17646 . 17655) (INT 17495 . 17498) (STATIC 17488 . 17494) (string 17467 . 17476) (INT 17299 . 17302) (STATIC 17292 . 17298) (string 17249 . 17256) (INT 17142 . 17145) (STATIC 17135 . 17141) (VOID 17087 . 17091))
    )
   (semanticdb-table "sched.c"
    :major-mode 'c-mode
    :tags 
        '( ("linux/mm.h" include (:system-flag t) nil [1196 1217])
            ("linux/module.h" include (:system-flag t) nil [1218 1243])
            ("linux/nmi.h" include (:system-flag t) nil [1244 1266])
            ("linux/init.h" include (:system-flag t) nil [1267 1290])
            ("linux/uaccess.h" include (:system-flag t) nil [1291 1317])
            ("linux/highmem.h" include (:system-flag t) nil [1318 1344])
            ("asm/mmu_context.h" include (:system-flag t) nil [1345 1373])
            ("linux/interrupt.h" include (:system-flag t) nil [1374 1402])
            ("linux/capability.h" include (:system-flag t) nil [1403 1432])
            ("linux/completion.h" include (:system-flag t) nil [1433 1462])
            ("linux/kernel_stat.h" include (:system-flag t) nil [1463 1493])
            ("linux/debug_locks.h" include (:system-flag t) nil [1494 1524])
            ("linux/perf_event.h" include (:system-flag t) nil [1525 1554])
            ("linux/security.h" include (:system-flag t) nil [1555 1582])
            ("linux/notifier.h" include (:system-flag t) nil [1583 1610])
            ("linux/profile.h" include (:system-flag t) nil [1611 1637])
            ("linux/freezer.h" include (:system-flag t) nil [1638 1664])
            ("linux/vmalloc.h" include (:system-flag t) nil [1665 1691])
            ("linux/blkdev.h" include (:system-flag t) nil [1692 1717])
            ("linux/delay.h" include (:system-flag t) nil [1718 1742])
            ("linux/pid_namespace.h" include (:system-flag t) nil [1743 1775])
            ("linux/smp.h" include (:system-flag t) nil [1776 1798])
            ("linux/threads.h" include (:system-flag t) nil [1799 1825])
            ("linux/timer.h" include (:system-flag t) nil [1826 1850])
            ("linux/rcupdate.h" include (:system-flag t) nil [1851 1878])
            ("linux/cpu.h" include (:system-flag t) nil [1879 1901])
            ("linux/cpuset.h" include (:system-flag t) nil [1902 1927])
            ("linux/percpu.h" include (:system-flag t) nil [1928 1953])
            ("linux/proc_fs.h" include (:system-flag t) nil [1954 1980])
            ("linux/seq_file.h" include (:system-flag t) nil [1981 2008])
            ("linux/stop_machine.h" include (:system-flag t) nil [2009 2040])
            ("linux/sysctl.h" include (:system-flag t) nil [2041 2066])
            ("linux/syscalls.h" include (:system-flag t) nil [2067 2094])
            ("linux/times.h" include (:system-flag t) nil [2095 2119])
            ("linux/tsacct_kern.h" include (:system-flag t) nil [2120 2150])
            ("linux/kprobes.h" include (:system-flag t) nil [2151 2177])
            ("linux/delayacct.h" include (:system-flag t) nil [2178 2206])
            ("linux/unistd.h" include (:system-flag t) nil [2207 2232])
            ("linux/pagemap.h" include (:system-flag t) nil [2233 2259])
            ("linux/hrtimer.h" include (:system-flag t) nil [2260 2286])
            ("linux/tick.h" include (:system-flag t) nil [2287 2310])
            ("linux/debugfs.h" include (:system-flag t) nil [2311 2337])
            ("linux/ctype.h" include (:system-flag t) nil [2338 2362])
            ("linux/ftrace.h" include (:system-flag t) nil [2363 2388])
            ("linux/slab.h" include (:system-flag t) nil [2389 2412])
            ("asm/tlb.h" include (:system-flag t) nil [2414 2434])
            ("asm/irq_regs.h" include (:system-flag t) nil [2435 2460])
            ("asm/mutex.h" include (:system-flag t) nil [2461 2483])
            ("sched_cpupri.h" include nil nil [2485 2510])
            ("workqueue_sched.h" include nil nil [2511 2539])
            ("sched_autogroup.h" include nil nil [2540 2568])
            ("CREATE_TRACE_POINTS" variable (:constant-flag t) nil [2578 2597])
            ("trace/events/sched.h" include (:system-flag t) nil [2598 2629])
            ("NICE_TO_PRIO" variable (:constant-flag t) nil [2759 2771])
            ("PRIO_TO_NICE" variable (:constant-flag t) nil [2814 2826])
            ("TASK_NICE" variable (:constant-flag t) nil [2869 2878])
            ("USER_PRIO" variable (:constant-flag t) nil [3090 3099])
            ("TASK_USER_PRIO" variable (:constant-flag t) nil [3130 3144])
            ("MAX_USER_PRIO" variable (:constant-flag t) nil [3184 3197])
            ("NS_TO_JIFFIES" variable (:constant-flag t) nil [3301 3314])
            ("NICE_0_LOAD" variable (:constant-flag t) nil [3376 3387])
            ("NICE_0_SHIFT" variable (:constant-flag t) nil [3414 3426])
            ("DEF_TIMESLICE" variable (:constant-flag t) nil [3626 3639])
            ("RUNTIME_INF" variable (:constant-flag t) nil [3742 3753])
            ("rt_policy" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("policy" variable (:type "int") (reparse-symbol arg-sub-list) [3796 3807]))                  
                :type "int")
                nil [3768 3893])
            ("task_has_rt_policy" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [3932 3954]))                  
                :type "int")
                nil [3895 3988])
            ("rt_prio_array" type
               (:members 
                  ( ("DECLARE_BITMAP" function
                       (:prototype-flag t
                        :arguments 
                          ( ("" variable (:type ("bitmap" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [4109 4116])
                            ("" variable (:type ("MAX_RT_PRIO" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [4117 4129]))                          
                        :type "int")
                        (reparse-symbol classsubparts) [4094 4132])
                    ("queue" variable
                       (:dereference 1
                        :type ("list_head" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [4168 4204]))                  
                :type "struct")
                nil [4070 4207])
            ("rt_bandwidth" type
               (:members 
                  ( ("rt_runtime_lock" variable (:type ("raw_spinlock_t" type (:type "class") nil nil)) (reparse-symbol classsubparts) [4265 4297])
                    ("rt_period" variable (:type ("ktime_t" type (:type "class") nil nil)) (reparse-symbol classsubparts) [4299 4319])
                    ("rt_runtime" variable (:type ("u64" type (:type "class") nil nil)) (reparse-symbol classsubparts) [4321 4338])
                    ("rt_period_timer" variable (:type ("hrtimer" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol classsubparts) [4340 4372]))                  
                :type "struct")
                nil [4209 4375])
            ("def_rt_bandwidth" variable
               (:typemodifiers ("static")
                :type ("rt_bandwidth" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [4377 4421])
            ("do_sched_rt_period_timer" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("rt_b" variable
                       (:pointer 1
                        :type ("rt_bandwidth" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [4459 4485])
                    ("overrun" variable (:type "int") (reparse-symbol arg-sub-list) [4486 4498]))                  
                :type "int")
                nil [4423 4499])
            ("sched_rt_period_timer" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("timer" variable
                       (:pointer 1
                        :type ("hrtimer" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [4551 4573]))                  
                :type ("hrtimer_restart" type (:type "enum") nil nil))
                nil [4501 4951])
            ("init_rt_bandwidth" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rt_b" variable
                       (:pointer 1
                        :type ("rt_bandwidth" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [4983 5009])
                    ("period" variable (:type ("u64" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [5010 5021])
                    ("runtime" variable (:type ("u64" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [5022 5034]))                  
                :type "void")
                nil [4953 5288])
            ("rt_bandwidth_enabled" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [5329 5334]))                  
                :type "int")
                nil [5290 5376])
            ("start_rt_bandwidth" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rt_b" variable
                       (:pointer 1
                        :type ("rt_bandwidth" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [5409 5435]))                  
                :type "void")
                nil [5378 6160])
            ("DEFINE_MUTEX" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type ("sched_domains_mutex" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [6449 6469]))                  
                :type "int")
                nil [6429 6470])
            ("cfs_rq" type
               (:members 
                  ( ("load" variable (:type ("load_weight" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol classsubparts) [8093 8117])
                    ("nr_running" variable (:type "unsigned long") (reparse-symbol classsubparts) [8119 8144])
                    ("exec_clock" variable (:type ("u64" type (:type "class") nil nil)) (reparse-symbol classsubparts) [8147 8162])
                    ("min_vruntime" variable (:type ("u64" type (:type "class") nil nil)) (reparse-symbol classsubparts) [8164 8181])
                    ("min_vruntime_copy" variable (:type ("u64" type (:type "class") nil nil)) (reparse-symbol classsubparts) [8204 8226])
                    ("tasks_timeline" variable (:type ("rb_root" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol classsubparts) [8236 8266])
                    ("rb_leftmost" variable
                       (:pointer 1
                        :type ("rb_node" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [8268 8296])
                    ("tasks" variable (:type ("list_head" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol classsubparts) [8299 8322])
                    ("balance_iterator" variable
                       (:pointer 1
                        :type ("list_head" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [8324 8359])
                    ("skip" variable
                       (:pointer 1
                        :type ("sched_entity" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [8504 8551])
                    ("last" variable
                       (:pointer 1
                        :type ("sched_entity" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [8504 8551])
                    ("next" variable
                       (:pointer 1
                        :type ("sched_entity" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [8504 8551])
                    ("curr" variable
                       (:pointer 1
                        :type ("sched_entity" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [8504 8551]))                  
                :type "struct")
                nil [8076 9789])
            ("rt_rq" type
               (:members 
                  ( ("active" variable (:type ("rt_prio_array" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol classsubparts) [9861 9889])
                    ("rt_nr_running" variable (:type "unsigned long") (reparse-symbol classsubparts) [9891 9919])
                    ("rt_throttled" variable (:type "int") (reparse-symbol classsubparts) [10250 10267])
                    ("rt_time" variable (:type ("u64" type (:type "class") nil nil)) (reparse-symbol classsubparts) [10269 10281])
                    ("rt_runtime" variable (:type ("u64" type (:type "class") nil nil)) (reparse-symbol classsubparts) [10283 10298])
                    ("rt_runtime_lock" variable (:type ("raw_spinlock_t" type (:type "class") nil nil)) (reparse-symbol classsubparts) [10333 10364]))                  
                :type "struct")
                nil [9845 10510])
            ("rq" type
               (:members 
                  ( ("lock" variable (:type ("raw_spinlock_t" type (:type "class") nil nil)) (reparse-symbol classsubparts) [11634 11654])
                    ("nr_running" variable (:type "unsigned long") (reparse-symbol classsubparts) [11801 11826])
                    ("CPU_LOAD_IDX_MAX" variable (:constant-flag t) (reparse-symbol classsubparts) [11836 11852])
                    ("cpu_load" variable
                       (:dereference 1
                        :type "unsigned long")
                        (reparse-symbol classsubparts) [11856 11897])
                    ("last_load_update_tick" variable (:type "unsigned long") (reparse-symbol classsubparts) [11899 11935])
                    ("skip_clock_update" variable (:type "int") (reparse-symbol classsubparts) [12015 12037])
                    ("load" variable (:type ("load_weight" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol classsubparts) [12090 12114])
                    ("nr_load_updates" variable (:type "unsigned long") (reparse-symbol classsubparts) [12116 12146])
                    ("nr_switches" variable (:type ("u64" type (:type "class") nil nil)) (reparse-symbol classsubparts) [12148 12164])
                    ("cfs" variable (:type ("cfs_rq" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol classsubparts) [12167 12185])
                    ("rt" variable (:type ("rt_rq" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol classsubparts) [12187 12203])
                    ("nr_uninterruptible" variable (:type "unsigned long") (reparse-symbol classsubparts) [12651 12684])
                    ("stop" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [12687 12726])
                    ("idle" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [12687 12726])
                    ("curr" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [12687 12726])
                    ("next_balance" variable (:type "unsigned long") (reparse-symbol classsubparts) [12728 12755])
                    ("prev_mm" variable
                       (:pointer 1
                        :type ("mm_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [12757 12783])
                    ("clock" variable (:type ("u64" type (:type "class") nil nil)) (reparse-symbol classsubparts) [12786 12796])
                    ("clock_task" variable (:type ("u64" type (:type "class") nil nil)) (reparse-symbol classsubparts) [12798 12813])
                    ("nr_iowait" variable (:type ("atomic_t" type (:type "class") nil nil)) (reparse-symbol classsubparts) [12816 12835])
                    ("calc_load_update" variable (:type "unsigned long") (reparse-symbol classsubparts) [13342 13373])
                    ("calc_load_active" variable (:type "long") (reparse-symbol classsubparts) [13375 13397]))                  
                :type "struct")
                nil [11599 14048])
            ("DEFINE_PER_CPU_SHARED_ALIGNED" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type ("rq" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol arg-sub-list) [14087 14097])
                    ("" variable (:type ("runqueues" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [14098 14108]))                  
                :type "int")
                nil [14050 14109])
            ("check_preempt_curr" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [14143 14157])
                    ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [14158 14180])
                    ("flags" variable (:type "int") (reparse-symbol arg-sub-list) [14181 14191]))                  
                :type "void")
                nil [14112 14192])
            ("cpu_of" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [14219 14233]))                  
                :type "int")
                nil [14194 14296])
            ("rcu_dereference_check_sched_domain" variable (:constant-flag t) nil [14306 14340])
            ("for_each_domain" variable (:constant-flag t) nil [14711 14726])
            ("cpu_rq" variable (:constant-flag t) nil [14842 14848])
            ("this_rq" variable (:constant-flag t) nil [14892 14899])
            ("task_rq" variable (:constant-flag t) nil [14939 14946])
            ("cpu_curr" variable (:constant-flag t) nil [14979 14987])
            ("raw_rq" variable (:constant-flag t) nil [15022 15028])
            ("set_task_rq" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [16238 16260])
                    ("cpu" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [16261 16278]))                  
                :type "void")
                nil [16207 16282])
            ("task_group" function
               (:pointer 1
                :typemodifiers ("static" "inline")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [16327 16349]))                  
                :type ("task_group" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [16283 16367])
            ("update_rq_clock_task" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [16436 16450])
                    ("delta" variable (:type ("s64" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [16451 16461]))                  
                :type "void")
                nil [16403 16462])
            ("update_rq_clock" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [16492 16506]))                  
                :type "void")
                nil [16464 16671])
            ("const_debug" variable (:constant-flag t) nil [16822 16833])
            ("runqueue_is_locked" function
               (:arguments 
                  ( ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [17131 17139]))                  
                :type "int")
                nil [17108 17191])
            ("SCHED_FEAT" variable (:constant-flag t) nil [17244 17254])
            ("" type (:type "enum") nil [17296 17333])
            ("SCHED_FEAT" variable (:constant-flag t) nil [17362 17372])
            ("sched_features.h" include nil nil [17482 17509])
            ("sched_feat" variable (:constant-flag t) nil [19096 19106])
            ("sysctl_sched_nr_migrate" variable
               (:typemodifiers ("static")
                :constant-flag t
                :type "unsigned int")
                nil [19277 19331])
            ("sysctl_sched_time_avg" variable
               (:typemodifiers ("static")
                :constant-flag t
                :type "unsigned int")
                nil [19434 19496])
            ("sysctl_sched_rt_period" variable (:type "unsigned int") nil [19578 19624])
            ("scheduler_running" variable (:type "int") nil [19647 19669])
            ("sysctl_sched_rt_runtime" variable (:type "int") nil [19755 19792])
            ("global_rt_period" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [19829 19834]))                  
                :type ("u64" type (:type "class") nil nil))
                nil [19794 19891])
            ("global_rt_runtime" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [19929 19934]))                  
                :type ("u64" type (:type "class") nil nil))
                nil [19893 20049])
            ("prepare_arch_switch" variable (:constant-flag t) nil [20088 20107])
            ("finish_arch_switch" variable (:constant-flag t) nil [20174 20192])
            ("task_current" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [20255 20269])
                    ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [20270 20292]))                  
                :type "int")
                nil [20224 20319])
            ("task_running" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [20352 20366])
                    ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [20367 20389]))                  
                :type "int")
                nil [20321 20472])
            ("prepare_lock_switch" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [20548 20562])
                    ("next" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [20563 20588]))                  
                :type "void")
                nil [20509 20781])
            ("finish_lock_switch" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [20821 20835])
                    ("prev" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [20836 20861]))                  
                :type "void")
                nil [20783 21458])
            ("__acquires" function
               (:arguments 
                  ( ("" variable (:type ("rq" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [22430 22433])
                    ("" variable (:type ("lock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [22434 22439]))                  
                :type "int")
                nil [22419 22634])
            ("__acquires" function
               (:arguments 
                  ( ("" variable (:type ("rq" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [22820 22823])
                    ("" variable (:type ("lock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [22824 22829]))                  
                :type "int")
                nil [22809 23085])
            ("__releases" function
               (:arguments 
                  ( ("" variable (:type ("rq" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [23143 23146])
                    ("" variable (:type ("lock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [23147 23152]))                  
                :type "int")
                nil [23132 23185])
            ("__releases" function
               (:arguments 
                  ( ("" variable (:type ("p" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [23315 23317])
                    ("" variable (:type ("pi_lock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [23318 23326]))                  
                :type "int")
                nil [23304 23409])
            ("__acquires" function
               (:arguments 
                  ( ("" variable (:type ("rq" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [23528 23531])
                    ("" variable (:type ("lock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [23532 23537]))                  
                :type "int")
                nil [23517 23637])
            ("hrtick_clear" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [26678 26692]))                  
                :type "void")
                nil [26646 26696])
            ("init_rq_hrtick" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [26732 26746]))                  
                :type "void")
                nil [26698 26750])
            ("init_hrtick" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [26783 26788]))                  
                :type "void")
                nil [26752 26792])
            ("resched_task" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [30398 30420]))                  
                :type "void")
                nil [30373 30494])
            ("sched_rt_avg_update" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [30528 30542])
                    ("rt_delta" variable (:type ("u64" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [30543 30556]))                  
                :type "void")
                nil [30496 30560])
            ("sched_avg_update" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [30591 30605]))                  
                :type "void")
                nil [30562 30609])
            ("WMULT_CONST" variable (:constant-flag t) nil [30702 30713])
            ("WMULT_SHIFT" variable (:constant-flag t) nil [30742 30753])
            ("SRR" variable (:constant-flag t) nil [30799 30802])
            ("calc_delta_mine" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("delta_exec" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [30914 30939])
                    ("weight" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [30940 30961])
                    ("lw" variable
                       (:pointer 1
                        :type ("load_weight" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [30964 30987]))                  
                :type "unsigned long")
                nil [30877 31868])
            ("update_load_add" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("lw" variable
                       (:pointer 1
                        :type ("load_weight" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [31905 31928])
                    ("inc" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [31929 31947]))                  
                :type "void")
                nil [31870 31992])
            ("update_load_sub" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("lw" variable
                       (:pointer 1
                        :type ("load_weight" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [32029 32052])
                    ("dec" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [32053 32071]))                  
                :type "void")
                nil [31994 32116])
            ("update_load_set" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("lw" variable
                       (:pointer 1
                        :type ("load_weight" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [32153 32176])
                    ("w" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [32177 32193]))                  
                :type "void")
                nil [32118 32235])
            ("WEIGHT_IDLEPRIO" variable (:constant-flag t) nil [32651 32666])
            ("WMULT_IDLEPRIO" variable (:constant-flag t) nil [32692 32706])
            ("prio_to_weight" variable
               (:dereference 1
                :typemodifiers ("static")
                :constant-flag t
                :type "int")
                nil [33302 33872])
            ("prio_to_wmult" variable
               (:dereference 1
                :typemodifiers ("static")
                :constant-flag t
                :type ("u32" type (:type "class") nil nil))
                nil [34119 34688])
            ("cpuacct_stat_index" type
               (:members 
                  ( ("CPUACCT_STAT_USER" variable
                       (:constant-flag t
                        :type "int")
                        (reparse-symbol enumsubparts) [34792 34810])
                    ("CPUACCT_STAT_SYSTEM" variable
                       (:constant-flag t
                        :type "int")
                        (reparse-symbol enumsubparts) [34832 34852])
                    ("CPUACCT_STAT_NSTATS" variable
                       (:constant-flag t
                        :type "int")
                        (reparse-symbol enumsubparts) [34877 34897]))                  
                :type "enum")
                nil [34765 34900])
            ("cpuacct_charge" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("tsk" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [35142 35166])
                    ("cputime" variable (:type ("u64" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [35167 35179]))                  
                :type "void")
                nil [35108 35182])
            ("cpuacct_update_stats" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("tsk" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [35223 35247])
                    ("idx" variable (:type ("cpuacct_stat_index" type (:type "enum") nil nil)) (reparse-symbol arg-sub-list) [35250 35278])
                    ("val" variable (:type ("cputime_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [35279 35293]))                  
                :type "void")
                nil [35183 35296])
            ("inc_cpu_load" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [35337 35351])
                    ("load" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [35352 35371]))                  
                :type "void")
                nil [35305 35410])
            ("dec_cpu_load" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [35444 35458])
                    ("load" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [35459 35478]))                  
                :type "void")
                nil [35412 35517])
            ("__acquires" function
               (:arguments 
                  ( ("" variable (:type ("rq2" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [41963 41967])
                    ("" variable (:type ("lock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [41968 41973]))                  
                :type "int")
                nil [41952 42097])
            ("__releases" function
               (:arguments 
                  ( ("" variable (:type ("rq2" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [42362 42366])
                    ("" variable (:type ("lock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [42367 42372]))                  
                :type "int")
                nil [42351 42450])
            ("calc_load_account_idle" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [42495 42513]))                  
                :type "void")
                nil [42460 42515])
            ("update_sysctl" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [42542 42547]))                  
                :type "void")
                nil [42516 42548])
            ("get_update_sysctl_factor" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [42585 42590]))                  
                :type "int")
                nil [42549 42591])
            ("update_cpu_load" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [42620 42638]))                  
                :type "void")
                nil [42592 42640])
            ("__set_task_cpu" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [42676 42698])
                    ("cpu" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [42699 42716]))                  
                :type "void")
                nil [42642 43017])
            ("rt_sched_class" variable
               (:typemodifiers ("static")
                :constant-flag t
                :type ("sched_class" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [43019 43066])
            ("sched_class_highest" variable (:constant-flag t) nil [43076 43095])
            ("for_each_class" variable (:constant-flag t) nil [43124 43138])
            ("sched_stats.h" include nil nil [43214 43238])
            ("inc_nr_running" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [43267 43281]))                  
                :type "void")
                nil [43240 43304])
            ("dec_nr_running" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [43333 43347]))                  
                :type "void")
                nil [43306 43370])
            ("set_load_weight" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [43400 43422]))                  
                :type "void")
                nil [43372 43780])
            ("enqueue_task" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [43807 43821])
                    ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [43822 43844])
                    ("flags" variable (:type "int") (reparse-symbol arg-sub-list) [43845 43855]))                  
                :type "void")
                nil [43782 43949])
            ("dequeue_task" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [43976 43990])
                    ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [43991 44013])
                    ("flags" variable (:type "int") (reparse-symbol arg-sub-list) [44014 44024]))                  
                :type "void")
                nil [43951 44120])
            ("activate_task" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [44203 44217])
                    ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [44218 44240])
                    ("flags" variable (:type "int") (reparse-symbol arg-sub-list) [44241 44251]))                  
                :type "void")
                nil [44177 44368])
            ("deactivate_task" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [44459 44473])
                    ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [44474 44496])
                    ("flags" variable (:type "int") (reparse-symbol arg-sub-list) [44497 44507]))                  
                :type "void")
                nil [44431 44624])
            ("sched_clock_irqtime" variable (:constant-flag t) nil [49148 49167])
            ("update_rq_clock_task" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [49206 49220])
                    ("delta" variable (:type ("s64" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [49221 49231]))                  
                :type "void")
                nil [49173 49261])
            ("sched_idletask.c" include nil nil [49304 49331])
            ("sched_fair.c" include nil nil [49332 49355])
            ("sched_rt.c" include nil nil [49356 49377])
            ("sched_autogroup.c" include nil nil [49378 49406])
            ("sched_stoptask.c" include nil nil [49407 49434])
            ("sched_set_stop_task" function
               (:arguments 
                  ( ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [49520 49528])
                    ("stop" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [49529 49554]))                  
                :type "void")
                nil [49495 50251])
            ("__normal_prio" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [50364 50386]))                  
                :type "int")
                nil [50332 50414])
            ("normal_prio" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [50703 50725]))                  
                :type "int")
                nil [50673 50857])
            ("effective_prio" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [51161 51183]))                  
                :type "int")
                nil [51135 51442])
            ("task_curr" function
               (:typemodifiers ("inline")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [51560 51588]))                  
                :type "int")
                nil [51539 51628])
            ("check_class_changed" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [51669 51683])
                    ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [51684 51706])
                    ("prev_class" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("sched_class" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [51718 51755])
                    ("oldprio" variable (:type "int") (reparse-symbol arg-sub-list) [51767 51779]))                  
                :type "void")
                nil [51630 52008])
            ("check_preempt_curr" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [52041 52055])
                    ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [52056 52078])
                    ("flags" variable (:type "int") (reparse-symbol arg-sub-list) [52079 52089]))                  
                :type "void")
                nil [52010 52631])
            ("ttwu_stat" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [60017 60039])
                    ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [60040 60048])
                    ("wake_flags" variable (:type "int") (reparse-symbol arg-sub-list) [60049 60064]))                  
                :type "void")
                nil [59995 60870])
            ("ttwu_activate" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [60898 60912])
                    ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [60913 60935])
                    ("en_flags" variable (:type "int") (reparse-symbol arg-sub-list) [60936 60949]))                  
                :type "void")
                nil [60872 61120])
            ("ttwu_do_wakeup" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [61213 61227])
                    ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [61228 61250])
                    ("wake_flags" variable (:type "int") (reparse-symbol arg-sub-list) [61251 61266]))                  
                :type "void")
                nil [61186 61693])
            ("ttwu_do_activate" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [61724 61738])
                    ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [61739 61761])
                    ("wake_flags" variable (:type "int") (reparse-symbol arg-sub-list) [61762 61777]))                  
                :type "void")
                nil [61695 61962])
            ("ttwu_remote" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [62237 62259])
                    ("wake_flags" variable (:type "int") (reparse-symbol arg-sub-list) [62260 62275]))                  
                :type "int")
                nil [62214 62440])
            ("ttwu_queue" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [64392 64414])
                    ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [64415 64423]))                  
                :type "void")
                nil [64369 64725])
            ("try_to_wake_up" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [65341 65363])
                    ("state" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [65364 65383])
                    ("wake_flags" variable (:type "int") (reparse-symbol arg-sub-list) [65384 65399]))                  
                :type "int")
                nil [65315 66764])
            ("try_to_wake_up_local" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [67075 67097]))                  
                :type "void")
                nil [67042 67548])
            ("wake_up_process" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [67976 67998]))                  
                :type "int")
                nil [67956 68042])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("wake_up_process" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [68057 68073]))                  
                :type "int")
                nil [68043 68074])
            ("wake_up_state" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [68094 68116])
                    ("state" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [68117 68136]))                  
                :type "int")
                nil [68076 68177])
            ("__sched_fork" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [68364 68386]))                  
                :type "void")
                nil [68339 68808])
            ("sched_fork" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [68863 68885]))                  
                :type "void")
                nil [68847 70660])
            ("wake_up_new_task" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [70943 70965]))                  
                :type "void")
                nil [70921 71579])
            ("fire_sched_in_preempt_notifiers" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("curr" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [72911 72936]))                  
                :type "void")
                nil [72867 72940])
            ("fire_sched_out_preempt_notifiers" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("curr" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [72987 73012])
                    ("next" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [73018 73043]))                  
                :type "void")
                nil [72942 73047])
            ("prepare_task_switch" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [73559 73573])
                    ("prev" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [73574 73599])
                    ("next" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [73606 73631]))                  
                :type "void")
                nil [73520 73847])
            ("__releases" function
               (:arguments 
                  ( ("" variable (:type ("rq" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [74575 74578])
                    ("" variable (:type ("lock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [74579 74584]))                  
                :type "int")
                nil [74564 75816])
            ("pre_schedule" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [76435 76449])
                    ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [76450 76472]))                  
                :type "void")
                nil [76403 76476])
            ("post_schedule" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [76511 76525]))                  
                :type "void")
                nil [76478 76529])
            ("__releases" function
               (:arguments 
                  ( ("" variable (:type ("rq" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [76730 76733])
                    ("" variable (:type ("lock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [76734 76739]))                  
                :type "int")
                nil [76719 77133])
            ("context_switch" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [77257 77271])
                    ("prev" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [77272 77297])
                    ("next" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [77306 77331]))                  
                :type "void")
                nil [77223 78463])
            ("nr_running" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [78754 78759]))                  
                :type "unsigned long")
                nil [78729 78861])
            ("nr_uninterruptible" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [78896 78901]))                  
                :type "unsigned long")
                nil [78863 79183])
            ("nr_context_switches" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [79224 79229]))                  
                :type "unsigned long long")
                nil [79185 79344])
            ("nr_iowait" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [79370 79375]))                  
                :type "unsigned long")
                nil [79346 79492])
            ("nr_iowait_cpu" function
               (:arguments 
                  ( ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [79522 79530]))                  
                :type "unsigned long")
                nil [79494 79605])
            ("this_cpu_load" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [79635 79640]))                  
                :type "unsigned long")
                nil [79607 79701])
            ("calc_load_tasks" variable
               (:typemodifiers ("static")
                :type ("atomic_long_t" type (:type "class") nil nil))
                nil [79748 79785])
            ("calc_load_update" variable
               (:typemodifiers ("static")
                :type "unsigned long")
                nil [79786 79824])
            ("avenrun" variable
               (:dereference 1
                :type "unsigned long")
                nil [79825 79850])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("avenrun" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [79865 79873]))                  
                :type "int")
                nil [79851 79874])
            ("calc_load_fold_active" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [79910 79928]))                  
                :type "long")
                nil [79876 80203])
            ("calc_load" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("load" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [80236 80255])
                    ("exp" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [80256 80274])
                    ("active" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [80275 80296]))                  
                :type "unsigned long")
                nil [80205 80403])
            ("calc_load_account_idle" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [84554 84572]))                  
                :type "void")
                nil [84519 84577])
            ("calc_load_fold_idle" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [84618 84623]))                  
                :type "long")
                nil [84579 84638])
            ("calc_global_nohz" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("ticks" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [84669 84689]))                  
                :type "void")
                nil [84640 84693])
            ("get_avenrun" function
               (:arguments 
                  ( ("loads" variable
                       (:pointer 1
                        :type "unsigned long")
                        (reparse-symbol arg-sub-list) [84949 84970])
                    ("offset" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [84971 84992])
                    ("shift" variable (:type "int") (reparse-symbol arg-sub-list) [84993 85003]))                  
                :type "void")
                nil [84932 85139])
            ("calc_global_load" function
               (:arguments 
                  ( ("ticks" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [85276 85296]))                  
                :type "void")
                nil [85254 85685])
            ("calc_load_account_active" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [85815 85833]))                  
                :type "void")
                nil [85778 86090])
            ("DEGRADE_SHIFT" variable (:constant-flag t) nil [87351 87364])
            ("degrade_zero_ticks" variable
               (:dereference 1
                :typemodifiers ("static")
                :constant-flag t
                :type "unsigned char")
                nil [87368 87456])
            ("degrade_factor" variable
               (:dereference 2
                :typemodifiers ("static")
                :constant-flag t
                :type "unsigned char")
                nil [87457 87709])
            ("decay_load_missed" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("load" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [87927 87946])
                    ("missed_updates" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [87947 87976])
                    ("idx" variable (:type "int") (reparse-symbol arg-sub-list) [87977 87985]))                  
                :type "unsigned long")
                nil [87888 88311])
            ("update_cpu_load" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [88543 88561]))                  
                :type "void")
                nil [88515 89676])
            ("update_cpu_load_active" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [89713 89731]))                  
                :type "void")
                nil [89678 89800])
            ("DEFINE_PER_CPU" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("kernel_stat" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol arg-sub-list) [90524 90543])
                    ("" variable (:type ("kstat" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [90544 90550]))                  
                :type "int")
                nil [90509 90551])
            ("EXPORT_PER_CPU_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("kstat" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [90575 90581]))                  
                :type "int")
                nil [90553 90582])
            ("do_task_delta_exec" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [90785 90807])
                    ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [90808 90822]))                  
                :type ("u64" type (:type "class") nil nil))
                nil [90755 90979])
            ("task_delta_exec" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [91016 91038]))                  
                :type "unsigned long long")
                nil [90981 91203])
            ("task_sched_runtime" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [91421 91443]))                  
                :type "unsigned long long")
                nil [91383 91633])
            ("account_user_time" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [91879 91901])
                    ("cputime" variable (:type ("cputime_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [91902 91920])
                    ("cputime_scaled" variable (:type ("cputime_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [91930 91955]))                  
                :type "void")
                nil [91856 92538])
            ("account_guest_time" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [92798 92820])
                    ("cputime" variable (:type ("cputime_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [92821 92839])
                    ("cputime_scaled" variable (:type ("cputime_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [92850 92875]))                  
                :type "void")
                nil [92767 93518])
            ("__account_system_time" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [93881 93903])
                    ("cputime" variable (:type ("cputime_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [93904 93922])
                    ("cputime_scaled" variable (:type ("cputime_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [93926 93951])
                    ("target_cputime64" variable
                       (:pointer 1
                        :type ("cputime64_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [93952 93982]))                  
                :type "void")
                nil [93840 94435])
            ("account_system_time" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [94751 94773])
                    ("hardirq_offset" variable (:type "int") (reparse-symbol arg-sub-list) [94774 94793])
                    ("cputime" variable (:type ("cputime_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [94798 94816])
                    ("cputime_scaled" variable (:type ("cputime_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [94817 94842]))                  
                :type "void")
                nil [94726 95333])
            ("account_steal_time" function
               (:arguments 
                  ( ("cputime" variable (:type ("cputime_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [95456 95474]))                  
                :type "void")
                nil [95432 95654])
            ("account_idle_time" function
               (:arguments 
                  ( ("cputime" variable (:type ("cputime_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [95757 95775]))                  
                :type "void")
                nil [95734 96089])
            ("irqtime_account_idle_ticks" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("ticks" variable (:type "int") (reparse-symbol arg-sub-list) [98297 98307]))                  
                :type "void")
                nil [98258 98310])
            ("irqtime_account_process_tick" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [98352 98374])
                    ("user_tick" variable (:type "int") (reparse-symbol arg-sub-list) [98375 98389])
                    ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [98396 98410]))                  
                :type "void")
                nil [98311 98413])
            ("account_process_tick" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [98645 98667])
                    ("user_tick" variable (:type "int") (reparse-symbol arg-sub-list) [98668 98682]))                  
                :type "void")
                nil [98619 99147])
            ("account_steal_ticks" function
               (:arguments 
                  ( ("ticks" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [99315 99335]))                  
                :type "void")
                nil [99290 99387])
            ("account_idle_ticks" function
               (:arguments 
                  ( ("ticks" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [99494 99514]))                  
                :type "void")
                nil [99470 99645])
            ("nsecs_to_cputime" variable (:constant-flag t) nil [100087 100103])
            ("task_times" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [100163 100185])
                    ("ut" variable
                       (:pointer 1
                        :type ("cputime_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [100186 100200])
                    ("st" variable
                       (:pointer 1
                        :type ("cputime_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [100201 100215]))                  
                :type "void")
                nil [100147 100743])
            ("thread_group_times" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [100813 100835])
                    ("ut" variable
                       (:pointer 1
                        :type ("cputime_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [100836 100850])
                    ("st" variable
                       (:pointer 1
                        :type ("cputime_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [100851 100865]))                  
                :type "void")
                nil [100789 101435])
            ("scheduler_tick" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [101578 101583]))                  
                :type "void")
                nil [101558 101979])
            ("get_parent_ip" function
               (:arguments 
                  ( ("addr" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [102017 102036]))                  
                :type "unsigned long")
                nil [101989 102167])
            ("__schedule_bug" function
               (:arguments 
                  ( ("prev" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [103307 103332]))                  
                :type "void")
                nil [103287 103640])
            ("schedule_debug" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("prev" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [103743 103768]))                  
                :type "void")
                nil [103709 104151])
            ("put_prev_task" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [104179 104193])
                    ("prev" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [104194 104219]))                  
                :type "void")
                nil [104153 104338])
            ("pick_next_task" function
               (:pointer 1
                :typemodifiers ("static" "inline")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [104431 104445]))                  
                :type ("task_struct" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [104381 104899])
            ("__schedule" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [104987 104992]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [104968 106722])
            ("sched_submit_work" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("tsk" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [106761 106785]))                  
                :type "void")
                nil [106724 106997])
            ("schedule" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [107032 107037]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [107015 107118])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("schedule" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [107133 107142]))                  
                :type "int")
                nil [107119 107143])
            ("default_wake_function" function
               (:arguments 
                  ( ("curr" variable
                       (:pointer 1
                        :type ("wait_queue_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [109693 109712])
                    ("mode" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [109713 109727])
                    ("wake_flags" variable (:type "int") (reparse-symbol arg-sub-list) [109728 109743])
                    ("key" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [109749 109759]))                  
                :type "int")
                nil [109667 109820])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("default_wake_function" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [109835 109857]))                  
                :type "int")
                nil [109821 109858])
            ("__wake_up_common" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("q" variable
                       (:pointer 1
                        :type ("wait_queue_head_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [110365 110386])
                    ("mode" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [110387 110405])
                    ("nr_exclusive" variable (:type "int") (reparse-symbol arg-sub-list) [110409 110426])
                    ("wake_flags" variable (:type "int") (reparse-symbol arg-sub-list) [110427 110442])
                    ("key" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [110443 110453]))                  
                :type "void")
                nil [110336 110699])
            ("__wake_up" function
               (:arguments 
                  ( ("q" variable
                       (:pointer 1
                        :type ("wait_queue_head_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [111090 111111])
                    ("mode" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [111112 111130])
                    ("nr_exclusive" variable (:type "int") (reparse-symbol arg-sub-list) [111134 111151])
                    ("key" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [111152 111162]))                  
                :type "void")
                nil [111075 111318])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("__wake_up" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [111333 111343]))                  
                :type "int")
                nil [111319 111344])
            ("__wake_up_locked" function
               (:arguments 
                  ( ("q" variable
                       (:pointer 1
                        :type ("wait_queue_head_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [111452 111473])
                    ("mode" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [111474 111492]))                  
                :type "void")
                nil [111430 111536])
            ("EXPORT_SYMBOL_GPL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("__wake_up_locked" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [111555 111572]))                  
                :type "int")
                nil [111537 111573])
            ("__wake_up_locked_key" function
               (:arguments 
                  ( ("q" variable
                       (:pointer 1
                        :type ("wait_queue_head_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [111601 111622])
                    ("mode" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [111623 111641])
                    ("key" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [111642 111652]))                  
                :type "void")
                nil [111575 111695])
            ("EXPORT_SYMBOL_GPL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("__wake_up_locked_key" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [111714 111735]))                  
                :type "int")
                nil [111696 111736])
            ("__wake_up_sync_key" function
               (:arguments 
                  ( ("q" variable
                       (:pointer 1
                        :type ("wait_queue_head_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [112476 112497])
                    ("mode" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [112498 112516])
                    ("nr_exclusive" variable (:type "int") (reparse-symbol arg-sub-list) [112520 112537])
                    ("key" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [112538 112548]))                  
                :type "void")
                nil [112452 112819])
            ("EXPORT_SYMBOL_GPL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("__wake_up_sync_key" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [112838 112857]))                  
                :type "int")
                nil [112820 112858])
            ("__wake_up_sync" function
               (:arguments 
                  ( ("q" variable
                       (:pointer 1
                        :type ("wait_queue_head_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [112932 112953])
                    ("mode" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [112954 112972])
                    ("nr_exclusive" variable (:type "int") (reparse-symbol arg-sub-list) [112973 112990]))                  
                :type "void")
                nil [112912 113044])
            ("EXPORT_SYMBOL_GPL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("__wake_up_sync" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [113063 113078]))                  
                :type "int")
                nil [113045 113079])
            ("complete" function
               (:arguments 
                  ( ("x" variable
                       (:pointer 1
                        :type ("completion" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [113614 113635]))                  
                :type "void")
                nil [113600 113817])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("complete" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [113832 113841]))                  
                :type "int")
                nil [113818 113842])
            ("complete_all" function
               (:arguments 
                  ( ("x" variable
                       (:pointer 1
                        :type ("completion" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [114218 114239]))                  
                :type "void")
                nil [114200 114433])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("complete_all" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [114448 114461]))                  
                :type "int")
                nil [114434 114462])
            ("do_wait_for_common" function
               (:arguments 
                  ( ("x" variable
                       (:pointer 1
                        :type ("completion" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [114510 114531])
                    ("timeout" variable (:type "long") (reparse-symbol arg-sub-list) [114532 114545])
                    ("state" variable (:type "int") (reparse-symbol arg-sub-list) [114546 114556]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [114483 115048])
            ("wait_for_common" function
               (:arguments 
                  ( ("x" variable
                       (:pointer 1
                        :type ("completion" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [115086 115107])
                    ("timeout" variable (:type "long") (reparse-symbol arg-sub-list) [115108 115121])
                    ("state" variable (:type "int") (reparse-symbol arg-sub-list) [115122 115132]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [115062 115284])
            ("wait_for_completion" function
               (:arguments 
                  ( ("x" variable
                       (:pointer 1
                        :type ("completion" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [115689 115710]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [115661 115779])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("wait_for_completion" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [115794 115814]))                  
                :type "int")
                nil [115780 115815])
            ("wait_for_completion_timeout" function
               (:arguments 
                  ( ("x" variable
                       (:pointer 1
                        :type ("completion" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [116216 116237])
                    ("timeout" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [116238 116260]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [116180 116323])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("wait_for_completion_timeout" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [116338 116366]))                  
                :type "int")
                nil [116324 116367])
            ("wait_for_completion_interruptible" function
               (:arguments 
                  ( ("x" variable
                       (:pointer 1
                        :type ("completion" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [116648 116669]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [116606 116792])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("wait_for_completion_interruptible" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [116807 116841]))                  
                :type "int")
                nil [116793 116842])
            ("wait_for_completion_interruptible_timeout" function
               (:arguments 
                  ( ("x" variable
                       (:pointer 1
                        :type ("completion" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [117247 117268])
                    ("timeout" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [117276 117298]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [117197 117359])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("wait_for_completion_interruptible_timeout" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [117374 117416]))                  
                :type "int")
                nil [117360 117417])
            ("wait_for_completion_killable" function
               (:arguments 
                  ( ("x" variable
                       (:pointer 1
                        :type ("completion" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [117709 117730]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [117672 117848])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("wait_for_completion_killable" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [117863 117892]))                  
                :type "int")
                nil [117849 117893])
            ("wait_for_completion_killable_timeout" function
               (:arguments 
                  ( ("x" variable
                       (:pointer 1
                        :type ("completion" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [118324 118345])
                    ("timeout" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [118355 118377]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [118279 118433])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("wait_for_completion_killable_timeout" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [118448 118485]))                  
                :type "int")
                nil [118434 118486])
            ("try_wait_for_completion" function
               (:arguments 
                  ( ("x" variable
                       (:pointer 1
                        :type ("completion" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [118944 118965]))                  
                :type "bool")
                nil [118915 119153])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("try_wait_for_completion" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [119168 119192]))                  
                :type "int")
                nil [119154 119193])
            ("completion_done" function
               (:arguments 
                  ( ("x" variable
                       (:pointer 1
                        :type ("completion" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [119426 119447]))                  
                :type "bool")
                nil [119405 119616])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("completion_done" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [119631 119647]))                  
                :type "int")
                nil [119617 119648])
            ("sleep_on_common" function
               (:arguments 
                  ( ("q" variable
                       (:pointer 1
                        :type ("wait_queue_head_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [119686 119707])
                    ("state" variable (:type "int") (reparse-symbol arg-sub-list) [119708 119718])
                    ("timeout" variable (:type "long") (reparse-symbol arg-sub-list) [119719 119732]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [119662 120095])
            ("interruptible_sleep_on" function
               (:arguments 
                  ( ("q" variable
                       (:pointer 1
                        :type ("wait_queue_head_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [120133 120154]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [120102 120221])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("interruptible_sleep_on" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [120236 120259]))                  
                :type "int")
                nil [120222 120260])
            ("interruptible_sleep_on_timeout" function
               (:arguments 
                  ( ("q" variable
                       (:pointer 1
                        :type ("wait_queue_head_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [120306 120327])
                    ("timeout" variable (:type "long") (reparse-symbol arg-sub-list) [120328 120341]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [120267 120402])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("interruptible_sleep_on_timeout" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [120417 120448]))                  
                :type "int")
                nil [120403 120449])
            ("sleep_on" function
               (:arguments 
                  ( ("q" variable
                       (:pointer 1
                        :type ("wait_queue_head_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [120473 120494]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [120456 120563])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("sleep_on" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [120578 120587]))                  
                :type "int")
                nil [120564 120588])
            ("sleep_on_timeout" function
               (:arguments 
                  ( ("q" variable
                       (:pointer 1
                        :type ("wait_queue_head_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [120620 120641])
                    ("timeout" variable (:type "long") (reparse-symbol arg-sub-list) [120642 120655]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [120595 120718])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("sleep_on_timeout" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [120733 120750]))                  
                :type "int")
                nil [120719 120751])
            ("set_user_nice" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [121874 121896])
                    ("nice" variable (:type "long") (reparse-symbol arg-sub-list) [121897 121907]))                  
                :type "void")
                nil [121855 123014])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("set_user_nice" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [123029 123043]))                  
                :type "int")
                nil [123015 123044])
            ("can_nice" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [123155 123183])
                    ("nice" variable
                       (:constant-flag t
                        :type "int")
                        (reparse-symbol arg-sub-list) [123184 123199]))                  
                :type "int")
                nil [123142 123375])
            ("task_prio" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [124476 124504]))                  
                :type "int")
                nil [124462 124539])
            ("task_nice" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [124646 124674]))                  
                :type "int")
                nil [124632 124700])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("task_nice" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [124715 124725]))                  
                :type "int")
                nil [124701 124726])
            ("idle_cpu" function
               (:arguments 
                  ( ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [124830 124838]))                  
                :type "int")
                nil [124817 124886])
            ("idle_task" function
               (:pointer 1
                :arguments 
                  ( ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [125015 125023]))                  
                :type ("task_struct" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [124985 125054])
            ("find_process_by_pid" function
               (:pointer 1
                :typemodifiers ("static")
                :arguments 
                  ( ("pid" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [125208 125218]))                  
                :type ("task_struct" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [125161 125270])
            ("__setscheduler" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [125353 125367])
                    ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [125368 125390])
                    ("policy" variable (:type "int") (reparse-symbol arg-sub-list) [125391 125402])
                    ("prio" variable (:type "int") (reparse-symbol arg-sub-list) [125403 125412]))                  
                :type "void")
                nil [125326 125692])
            ("check_same_owner" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [125803 125825]))                  
                :type "bool")
                nil [125774 126116])
            ("__sched_setscheduler" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [126150 126172])
                    ("policy" variable (:type "int") (reparse-symbol arg-sub-list) [126173 126184])
                    ("param" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("sched_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [126189 126221])
                    ("user" variable (:type "bool") (reparse-symbol arg-sub-list) [126222 126232]))                  
                :type "int")
                nil [126118 129978])
            ("sched_setscheduler" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [130248 130270])
                    ("policy" variable (:type "int") (reparse-symbol arg-sub-list) [130271 130282])
                    ("param" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("sched_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [130292 130324]))                  
                :type "int")
                nil [130225 130382])
            ("EXPORT_SYMBOL_GPL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("sched_setscheduler" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [130401 130420]))                  
                :type "int")
                nil [130383 130421])
            ("sched_setscheduler_nocheck" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [130934 130956])
                    ("policy" variable (:type "int") (reparse-symbol arg-sub-list) [130957 130968])
                    ("param" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("sched_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [130979 131011]))                  
                :type "int")
                nil [130903 131070])
            ("do_sched_setscheduler" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("pid" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [131105 131115])
                    ("policy" variable (:type "int") (reparse-symbol arg-sub-list) [131116 131127])
                    ("__user" variable (:type ("sched_param" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol arg-sub-list) [131128 131155])
                    ("" variable (:type ("param" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [131155 131161]))                  
                :type "int")
                nil [131072 131528])
            ("SYSCALL_DEFINE3" function
               (:arguments 
                  ( ("" variable (:type ("sched_setscheduler" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [131737 131756])
                    ("" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [131757 131763])
                    ("" variable (:type ("pid" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [131764 131768])
                    ("" variable (:type "int") (reparse-symbol arg-sub-list) [131769 131773])
                    ("" variable (:type ("policy" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [131774 131781])
                    ("__user" variable (:type ("sched_param" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol arg-sub-list) [131784 131811])
                    ("" variable (:type ("param" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [131813 131819]))                  
                :type "int")
                nil [131721 131958])
            ("SYSCALL_DEFINE2" function
               (:arguments 
                  ( ("" variable (:type ("sched_setparam" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [132130 132145])
                    ("" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [132146 132152])
                    ("" variable (:type ("pid" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [132153 132157])
                    ("__user" variable (:type ("sched_param" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol arg-sub-list) [132158 132185])
                    ("" variable (:type ("param" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [132187 132193]))                  
                :type "int")
                nil [132114 132244])
            ("SYSCALL_DEFINE1" function
               (:arguments 
                  ( ("" variable (:type ("sched_getscheduler" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [132374 132393])
                    ("" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [132394 132400])
                    ("" variable (:type ("pid" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [132401 132405]))                  
                :type "int")
                nil [132358 132733])
            ("SYSCALL_DEFINE2" function
               (:arguments 
                  ( ("" variable (:type ("sched_getparam" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [132894 132909])
                    ("" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [132910 132916])
                    ("" variable (:type ("pid" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [132917 132921])
                    ("__user" variable (:type ("sched_param" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol arg-sub-list) [132922 132949])
                    ("" variable (:type ("param" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [132951 132957]))                  
                :type "int")
                nil [132878 133502])
            ("sched_setaffinity" function
               (:arguments 
                  ( ("pid" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [133527 133537])
                    ("in_mask" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("cpumask" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [133538 133568]))                  
                :type "long")
                nil [133504 134855])
            ("get_user_cpu_mask" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("__user" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [134886 134908])
                    ("" variable (:type ("user_mask_ptr" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [134908 134922])
                    ("len" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [134923 134936])
                    ("new_mask" variable
                       (:pointer 1
                        :type ("cpumask" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [134945 134970]))                  
                :type "int")
                nil [134857 135153])
            ("SYSCALL_DEFINE3" function
               (:arguments 
                  ( ("" variable (:type ("sched_setaffinity" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [135394 135412])
                    ("" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [135413 135419])
                    ("" variable (:type ("pid" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [135420 135424])
                    ("" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [135425 135438])
                    ("" variable (:type ("len" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [135439 135443])
                    ("__user" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [135446 135468])
                    ("" variable (:type ("user_mask_ptr" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [135470 135484]))                  
                :type "int")
                nil [135378 135761])
            ("sched_getaffinity" function
               (:arguments 
                  ( ("pid" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [135786 135796])
                    ("mask" variable
                       (:pointer 1
                        :type ("cpumask" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [135797 135818]))                  
                :type "long")
                nil [135763 136291])
            ("SYSCALL_DEFINE3" function
               (:arguments 
                  ( ("" variable (:type ("sched_getaffinity" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [136541 136559])
                    ("" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [136560 136566])
                    ("" variable (:type ("pid" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [136567 136571])
                    ("" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [136572 136585])
                    ("" variable (:type ("len" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [136586 136590])
                    ("__user" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [136593 136615])
                    ("" variable (:type ("user_mask_ptr" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [136617 136631]))                  
                :type "int")
                nil [136525 137088])
            ("SYSCALL_DEFINE0" function
               (:arguments 
                  ( ("" variable (:type ("sched_yield" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [137325 137337]))                  
                :type "int")
                nil [137309 137716])
            ("should_resched" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [137751 137756]))                  
                :type "int")
                nil [137718 137823])
            ("__cond_resched" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [137852 137857]))                  
                :type "void")
                nil [137825 137948])
            ("_cond_resched" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [137976 137981]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [137954 138056])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("_cond_resched" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [138071 138085]))                  
                :type "int")
                nil [138057 138086])
            ("__cond_resched_lock" function
               (:arguments 
                  ( ("lock" variable
                       (:pointer 1
                        :type ("spinlock_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [138437 138454]))                  
                :type "int")
                nil [138413 138701])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("__cond_resched_lock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [138716 138736]))                  
                :type "int")
                nil [138702 138737])
            ("__cond_resched_softirq" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [138774 138779]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [138743 138922])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("__cond_resched_softirq" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [138937 138960]))                  
                :type "int")
                nil [138923 138961])
            ("yield" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [139161 139166]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [139147 139224])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("yield" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [139239 139245]))                  
                :type "int")
                nil [139225 139246])
            ("yield_to" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [139671 139693])
                    ("preempt" variable (:type "bool") (reparse-symbol arg-sub-list) [139694 139707]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [139654 140514])
            ("EXPORT_SYMBOL_GPL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("yield_to" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [140533 140542]))                  
                :type "int")
                nil [140515 140543])
            ("io_schedule" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [140719 140724]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [140699 140953])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("io_schedule" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [140968 140980]))                  
                :type "int")
                nil [140954 140981])
            ("io_schedule_timeout" function
               (:arguments 
                  ( ("timeout" variable (:type "long") (reparse-symbol arg-sub-list) [141016 141029]))                  
                :type ("__sched" type (:type "class") nil nil))
                nil [140988 141303])
            ("SYSCALL_DEFINE1" function
               (:arguments 
                  ( ("" variable (:type ("sched_get_priority_max" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [141519 141542])
                    ("" variable (:type "int") (reparse-symbol arg-sub-list) [141543 141547])
                    ("" variable (:type ("policy" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [141548 141555]))                  
                :type "int")
                nil [141503 141763])
            ("SYSCALL_DEFINE1" function
               (:arguments 
                  ( ("" variable (:type ("sched_get_priority_min" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [141979 142002])
                    ("" variable (:type "int") (reparse-symbol arg-sub-list) [142003 142007])
                    ("" variable (:type ("policy" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [142008 142015]))                  
                :type "int")
                nil [141963 142197])
            ("SYSCALL_DEFINE2" function
               (:arguments 
                  ( ("" variable (:type ("sched_rr_get_interval" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [142526 142548])
                    ("" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [142549 142555])
                    ("" variable (:type ("pid" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [142556 142560])
                    ("__user" variable (:type ("timespec" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol arg-sub-list) [142563 142587])
                    ("" variable (:type ("interval" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [142589 142598]))                  
                :type "int")
                nil [142510 143231])
            ("stat_nam" variable
               (:dereference 1
                :typemodifiers ("static")
                :constant-flag t
                :type "char")
                nil [143233 143287])
            ("sched_show_task" function
               (:arguments 
                  ( ("p" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [143310 143332]))                  
                :type "void")
                nil [143289 144039])
            ("show_state_filter" function
               (:arguments 
                  ( ("state_filter" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [144064 144091]))                  
                :type "void")
                nil [144041 144819])
            ("init_idle_bootup_task" function
               (:arguments 
                  ( ("idle" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [144858 144883]))                  
                :type ("__cpuinit" type (:type "class") nil nil))
                nil [144826 144927])
            ("init_idle" function
               (:arguments 
                  ( ("idle" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [145188 145213])
                    ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [145214 145222]))                  
                :type ("__cpuinit" type (:type "class") nil nil))
                nil [145168 146227])
            ("nohz_cpu_mask" variable (:type ("cpumask_var_t" type (:type "class") nil nil)) nil [146504 146532])
            ("get_update_sysctl_factor" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [146897 146902]))                  
                :type "int")
                nil [146861 147241])
            ("update_sysctl" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [147269 147274]))                  
                :type "void")
                nil [147243 147533])
            ("sched_init_granularity" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [147577 147582]))                  
                :type "void")
                nil [147535 147604])
            ("sched_init_smp" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [193306 193311]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [193284 193342])
            ("sysctl_timer_migration" variable
               (:typemodifiers ("static")
                :constant-flag t
                :type "unsigned int")
                nil [193368 193420])
            ("in_sched_functions" function
               (:arguments 
                  ( ("addr" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [193445 193464]))                  
                :type "int")
                nil [193422 193594])
            ("init_cfs_rq" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("cfs_rq" variable
                       (:pointer 1
                        :type ("cfs_rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [193620 193642])
                    ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [193643 193657]))                  
                :type "void")
                nil [193596 194010])
            ("init_rt_rq" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rt_rq" variable
                       (:pointer 1
                        :type ("rt_rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [194035 194055])
                    ("rq" variable
                       (:pointer 1
                        :type ("rq" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [194056 194070]))                  
                :type "void")
                nil [194012 194824])
            ("sched_init" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [195921 195926]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [195903 201051])
            ("free_fair_sched_group" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("tg" variable
                       (:pointer 1
                        :type ("task_group" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [206232 206254]))                  
                :type "void")
                nil [206191 206258])
            ("alloc_fair_sched_group" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("tg" variable
                       (:pointer 1
                        :type ("task_group" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [206301 206323])
                    ("parent" variable
                       (:pointer 1
                        :type ("task_group" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [206324 206350]))                  
                :type "int")
                nil [206260 206365])
            ("unregister_fair_sched_group" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("tg" variable
                       (:pointer 1
                        :type ("task_group" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [206414 206436])
                    ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [206437 206445]))                  
                :type "void")
                nil [206367 206449])
            ("free_rt_sched_group" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("tg" variable
                       (:pointer 1
                        :type ("task_group" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [207661 207683]))                  
                :type "void")
                nil [207622 207687])
            ("alloc_rt_sched_group" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("tg" variable
                       (:pointer 1
                        :type ("task_group" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [207728 207750])
                    ("parent" variable
                       (:pointer 1
                        :type ("task_group" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [207751 207777]))                  
                :type "int")
                nil [207689 207792])
            ("sched_rt_global_constraints" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [215919 215924]))                  
                :type "int")
                nil [215880 216512])
            ("sched_rt_handler" function
               (:arguments 
                  ( ("table" variable
                       (:pointer 1
                        :type ("ctl_table" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [216570 216594])
                    ("write" variable (:type "int") (reparse-symbol arg-sub-list) [216595 216605])
                    ("__user" variable (:type "void") (reparse-symbol arg-sub-list) [216608 216621])
                    ("" variable (:type ("buffer" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [216621 216628])
                    ("lenp" variable
                       (:pointer 1
                        :type ("size_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [216629 216642])
                    ("ppos" variable
                       (:pointer 1
                        :type ("loff_t" type (:type "class") nil nil))
                        (reparse-symbol arg-sub-list) [216645 216658]))                  
                :type "int")
                nil [216549 217223]))          
    :file "sched.c"
    :pointmax 226995
    :fsize 226994
    :lastmodtime '(21468 9212 917217 456000)
    :unmatched-syntax '((punctuation 216620 . 216621) (VOID 195898 . 195902) (VOID 193279 . 193283) (VOID 145163 . 145167) (VOID 144821 . 144825) (punctuation 142586 . 142587) (LONG 140983 . 140987) (VOID 140694 . 140698) (BOOL 139649 . 139653) (VOID 139142 . 139146) (INT 138739 . 138742) (INT 137950 . 137953) (punctuation 136614 . 136615) (punctuation 135467 . 135468) (punctuation 134907 . 134908) (punctuation 132948 . 132949) (punctuation 132184 . 132185) (punctuation 131810 . 131811) (punctuation 131154 . 131155) (LONG 120590 . 120594) (VOID 120451 . 120455) (LONG 120262 . 120266) (VOID 120097 . 120101) (LONG 119657 . 119661) (STATIC 119650 . 119656) (LONG 118274 . 118278) (INT 117668 . 117671) (LONG 117192 . 117196) (INT 116602 . 116605) (LONG 116175 . 116179) (UNSIGNED 116166 . 116174) (VOID 115656 . 115660) (LONG 115057 . 115061) (STATIC 115050 . 115056) (LONG 114478 . 114482) (INLINE 114471 . 114477) (STATIC 114464 . 114470) (VOID 107010 . 107014) (symbol 106999 . 107009) (VOID 104963 . 104967) (STATIC 104956 . 104962) (symbol 103278 . 103286) (STATIC 103271 . 103277) (symbol 101981 . 101988) (semantic-list "(&__get_cpu_var(runqueues))" 89724 . 89731) (spp-arg-list nil 89724 . 89731) (semantic-list "(&__get_cpu_var(runqueues))" 88554 . 88561) (spp-arg-list nil 88554 . 88561) (semantic-list "(&__get_cpu_var(runqueues))" 85826 . 85833) (spp-arg-list nil 85826 . 85833) (semantic-list "(&__get_cpu_var(runqueues))" 84565 . 84572) (spp-arg-list nil 84565 . 84572) (semantic-list "(&__get_cpu_var(runqueues))" 79921 . 79928) (spp-arg-list nil 79921 . 79928) (punctuation 76733 . 76734) (punctuation 76732 . 76733) (semantic-list 76691 . 76717) (symbol 76678 . 76691) (VOID 76673 . 76677) (symbol 76662 . 76672) (punctuation 74578 . 74579) (punctuation 74577 . 74578) (semantic-list 74521 . 74562) (symbol 74503 . 74521) (VOID 74498 . 74502) (STATIC 74491 . 74497) (semantic-list "(&__get_cpu_var(runqueues))" 42631 . 42638) (spp-arg-list nil 42631 . 42638) (semantic-list "(&__get_cpu_var(runqueues))" 42506 . 42513) (spp-arg-list nil 42506 . 42513) (punctuation 42366 . 42367) (punctuation 42365 . 42366) (semantic-list 42338 . 42349) (symbol 42328 . 42338) (punctuation 42343 . 42344) (punctuation 42342 . 42343) (semantic-list 42294 . 42326) (symbol 42278 . 42294) (VOID 42273 . 42277) (STATIC 42266 . 42272) (punctuation 41967 . 41968) (punctuation 41966 . 41967) (semantic-list 41939 . 41950) (symbol 41929 . 41939) (punctuation 41944 . 41945) (punctuation 41943 . 41944) (semantic-list 41895 . 41927) (symbol 41881 . 41895) (VOID 41876 . 41880) (STATIC 41869 . 41875) (punctuation 23531 . 23532) (punctuation 23530 . 23531) (semantic-list 23509 . 23515) (symbol 23497 . 23509) (punctuation 23496 . 23497) (symbol 23493 . 23495) (STRUCT 23486 . 23492) (STATIC 23479 . 23485) (punctuation 23317 . 23318) (punctuation 23316 . 23317) (semantic-list 23292 . 23302) (symbol 23282 . 23292) (punctuation 23296 . 23297) (punctuation 23295 . 23296) (semantic-list 23220 . 23280) (symbol 23206 . 23220) (VOID 23201 . 23205) (INLINE 23194 . 23200) (STATIC 23187 . 23193) (punctuation 23146 . 23147) (punctuation 23145 . 23146) (semantic-list 23115 . 23130) (symbol 23099 . 23115) (VOID 23094 . 23098) (STATIC 23087 . 23093) (punctuation 22823 . 22824) (punctuation 22822 . 22823) (semantic-list 22795 . 22807) (symbol 22785 . 22795) (punctuation 22798 . 22799) (punctuation 22797 . 22798) (semantic-list 22738 . 22783) (symbol 22726 . 22738) (punctuation 22725 . 22726) (symbol 22722 . 22724) (STRUCT 22715 . 22721) (STATIC 22708 . 22714) (punctuation 22433 . 22434) (punctuation 22432 . 22433) (semantic-list 22394 . 22417) (symbol 22380 . 22394) (punctuation 22379 . 22380) (symbol 22376 . 22378) (STRUCT 22369 . 22375) (INLINE 22362 . 22368) (STATIC 22355 . 22361) (symbol 19633 . 19646) (STATIC 19626 . 19632) (punctuation 17512 . 17513) (number 17511 . 17512) (punctuation 17480 . 17481) (symbol 17458 . 17479) (INT 17454 . 17457) (UNSIGNED 17445 . 17453) (CONST "const" 17433 . 17444) (STATIC "static" 17433 . 17444) (spp-include "sched_features.h" 17303 . 17330) (number 4129 . 4130) (punctuation 4128 . 4129))
    :lexical-table 
        '(("MAX_USER_PRIO" . ((semantic-list "(USER_PRIO(MAX_PRIO))" 3199 . 3220)))
          ("finish_arch_switch" (spp-arg-list ("prev") 20192 . 20198) . 
              ((DO "do" 20199 . 20201) (semantic-list "{ }" 20202 . 20205) (WHILE "while" 20206 . 20211) (semantic-list "(0)" 20212 . 20215)))
          ("WMULT_SHIFT" . ((number "32" 30754 . 30756)))
          ("cpu_rq" (spp-arg-list ("cpu") 14848 . 14853) . ((semantic-list "(&per_cpu(runqueues, (cpu)))" 14855 . 14883)))
          ("const_debug" . ((STATIC "static" 16834 . 16840) (CONST "const" 16841 . 16846)))
          ("for_each_class" (spp-arg-list ("class") 43138 . 43145) . ((FOR "for" 43151 . 43154) (semantic-list "(class = sched_class_highest; class; class = class->next)" 43155 . 43212)))
          ("DEF_TIMESLICE" . ((semantic-list "(100 * HZ / 1000)" 3641 . 3658)))
          ("raw_rq" (spp-arg-list nil 15028 . 15030) . ((semantic-list "(&__raw_get_cpu_var(runqueues))" 15032 . 15063)))
          ("DEGRADE_SHIFT" . ((number "7" 87366 . 87367)))
          ("for_each_domain" (spp-arg-list ("cpu" "__sd") 14726 . 14737) . ((FOR "for" 14741 . 14744) (semantic-list "(__sd = rcu_dereference_check_sched_domain(cpu_rq(cpu)->sd); __sd; __sd = __sd->parent)" 14745 . 14832)))
          ("CPU_LOAD_IDX_MAX" . ((number "5" 11853 . 11854)))
          ("cpu_curr" (spp-arg-list ("cpu") 14987 . 14992) . ((semantic-list "(cpu_rq(cpu)->curr)" 14994 . 15013)))
          ("WMULT_CONST" . ((semantic-list "(1UL << 32)" 30714 . 30725)))
          ("NICE_TO_PRIO" (spp-arg-list ("nice") 2771 . 2777) . ((semantic-list "(MAX_RT_PRIO + (nice) + 20)" 2778 . 2805)))
          ("PRIO_TO_NICE" (spp-arg-list ("prio") 2826 . 2832) . ((semantic-list "((prio) - MAX_RT_PRIO - 20)" 2833 . 2860)))
          ("USER_PRIO" (spp-arg-list ("p") 3099 . 3102) . ((semantic-list "((p)-MAX_RT_PRIO)" 3104 . 3121)))
          ("NS_TO_JIFFIES" (spp-arg-list ("TIME") 3314 . 3320) . ((semantic-list "((unsigned long)(TIME) / (NSEC_PER_SEC / HZ))" 3321 . 3366)))
          ("sched_feat" (spp-arg-list ("x") 19106 . 19109) . ((semantic-list "(sysctl_sched_features & (1UL << __SCHED_FEAT_##x))" 19110 . 19161)))
          ("TASK_NICE" (spp-arg-list ("p") 2878 . 2881) . ((symbol "PRIO_TO_NICE" 2883 . 2895) (semantic-list "((p)->static_prio)" 2895 . 2913)))
          ("rcu_dereference_check_sched_domain" (spp-arg-list ("p") 14340 . 14343) . ((symbol "rcu_dereference_check" 14347 . 14368) (semantic-list "((p), \\
			      rcu_read_lock_held() || \\
			      lockdep_is_held(&sched_domains_mutex))" 14368 . 14458)))
          ("prepare_arch_switch" (spp-arg-list ("next") 20107 . 20113) . 
              ((DO "do" 20114 . 20116) (semantic-list "{ }" 20117 . 20120) (WHILE "while" 20121 . 20126) (semantic-list "(0)" 20127 . 20130)))
          ("nsecs_to_cputime" (spp-arg-list ("__nsecs") 100103 . 100112) . ((symbol "nsecs_to_jiffies" 100113 . 100129) (semantic-list "(__nsecs)" 100129 . 100138)))
          ("task_rq" (spp-arg-list ("p") 14946 . 14949) . ((symbol "cpu_rq" 14951 . 14957) (semantic-list "(task_cpu(p))" 14957 . 14970)))
          ("NICE_0_LOAD" . ((symbol "SCHED_LOAD_SCALE" 3389 . 3405)))
          ("SRR" (spp-arg-list ("x" "y") 30802 . 30808) . ((semantic-list "(((x) + (1UL << ((y) - 1))) >> (y))" 30809 . 30844)))
          ("WEIGHT_IDLEPRIO" . ((number "3" 32682 . 32683)))
          ("sched_class_highest" . ((semantic-list "(&stop_sched_class)" 43096 . 43115)))
          ("RUNTIME_INF" . ((semantic-list "((u64)~0ULL)" 3754 . 3766)))
          ("this_rq" (spp-arg-list nil 14899 . 14901) . ((semantic-list "(&__get_cpu_var(runqueues))" 14903 . 14930)))
          ("CREATE_TRACE_POINTS")
          ("TASK_USER_PRIO" (spp-arg-list ("p") 3144 . 3147) . ((symbol "USER_PRIO" 3148 . 3157) (semantic-list "((p)->static_prio)" 3157 . 3175)))
          ("NICE_0_SHIFT" . ((symbol "SCHED_LOAD_SHIFT" 3428 . 3444)))
          ("WMULT_IDLEPRIO" . ((number "1431655765" 32715 . 32725)))
          ("sched_clock_irqtime" . ((semantic-list "(0)" 49168 . 49171)))
          )

    )
   (semanticdb-table "sched_cpupri.h"
    :file "sched_cpupri.h"
    :fsize 931
    :lastmodtime '(21468 9212 978216 12000)
    )
   (semanticdb-table "workqueue_sched.h"
    :file "workqueue_sched.h"
    :fsize 311
    :lastmodtime '(21468 9214 547178 865000)
    )
   (semanticdb-table "sched_autogroup.h"
    :file "sched_autogroup.h"
    :fsize 947
    :lastmodtime '(21468 9212 947216 746000)
    )
   (semanticdb-table "sched_features.h"
    :file "sched_features.h"
    :fsize 1884
    :lastmodtime '(21468 9213 12215 207000)
    )
   (semanticdb-table "sched_stats.h"
    :file "sched_stats.h"
    :fsize 9466
    :lastmodtime '(21468 9213 49214 331000)
    )
   (semanticdb-table "sched_idletask.c"
    :file "sched_idletask.c"
    :fsize 2135
    :lastmodtime '(21468 9213 28214 828000)
    )
   (semanticdb-table "sched_fair.c"
    :file "sched_fair.c"
    :fsize 112098
    :lastmodtime '(21468 9213 3215 420000)
    )
   (semanticdb-table "sched_rt.c"
    :file "sched_rt.c"
    :fsize 43200
    :lastmodtime '(21468 9213 37214 615000)
    )
   (semanticdb-table "sched_autogroup.c"
    :file "sched_autogroup.c"
    :fsize 6178
    :lastmodtime '(21468 9212 933217 77000)
    )
   (semanticdb-table "sched_stoptask.c"
    :file "sched_stoptask.c"
    :fsize 2148
    :lastmodtime '(21468 9213 56214 165000)
    )
   (semanticdb-table "softirq.c"
    :major-mode 'c-mode
    :tags 
        '( ("linux/module.h" include (:system-flag t) nil [243 268])
            ("linux/kernel_stat.h" include (:system-flag t) nil [269 299])
            ("linux/interrupt.h" include (:system-flag t) nil [300 328])
            ("linux/init.h" include (:system-flag t) nil [329 352])
            ("linux/mm.h" include (:system-flag t) nil [353 374])
            ("linux/notifier.h" include (:system-flag t) nil [375 402])
            ("linux/percpu.h" include (:system-flag t) nil [403 428])
            ("linux/cpu.h" include (:system-flag t) nil [429 451])
            ("linux/freezer.h" include (:system-flag t) nil [452 478])
            ("linux/kthread.h" include (:system-flag t) nil [479 505])
            ("linux/rcupdate.h" include (:system-flag t) nil [506 533])
            ("linux/ftrace.h" include (:system-flag t) nil [534 559])
            ("linux/smp.h" include (:system-flag t) nil [560 582])
            ("linux/tick.h" include (:system-flag t) nil [583 606])
            ("CREATE_TRACE_POINTS" variable (:constant-flag t) nil [616 635])
            ("trace/events/irq.h" include (:system-flag t) nil [636 665])
            ("asm/irq.h" include (:system-flag t) nil [667 687])
            ("____cacheline_aligned" variable (:type "int") nil [1423 1445])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("irq_stat" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [1460 1469]))                  
                :type "int")
                nil [1446 1470])
            ("__cacheline_aligned_in_smp" variable (:type "int") nil [1533 1560])
            ("DEFINE_PER_CPU" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [1577 1598])
                    ("" variable (:type ("ksoftirqd" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [1599 1609]))                  
                :type "int")
                nil [1562 1610])
            ("softirq_to_name" variable
               (:pointer 1
                :dereference 1
                :type "char")
                nil [1612 1752])
            ("wakeup_softirqd" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [2008 2013]))                  
                :type "void")
                nil [1980 2196])
            ("__local_bh_disable" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("ip" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [3489 3506])
                    ("cnt" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [3507 3524]))                  
                :type "void")
                nil [3451 3565])
            ("local_bh_disable" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [3624 3629]))                  
                :type "void")
                nil [3602 3726])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("local_bh_disable" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [3742 3759]))                  
                :type "int")
                nil [3728 3760])
            ("__local_bh_enable" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("cnt" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [3792 3809]))                  
                :type "void")
                nil [3762 3991])
            ("_local_bh_enable" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [4169 4174]))                  
                :type "void")
                nil [4147 4222])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("_local_bh_enable" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [4238 4255]))                  
                :type "int")
                nil [4224 4256])
            ("_local_bh_enable_ip" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("ip" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [4297 4314]))                  
                :type "void")
                nil [4258 4862])
            ("local_bh_enable" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [4885 4890]))                  
                :type "void")
                nil [4864 4960])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("local_bh_enable" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [4975 4991]))                  
                :type "int")
                nil [4961 4992])
            ("local_bh_enable_ip" function
               (:arguments 
                  ( ("ip" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [5018 5035]))                  
                :type "void")
                nil [4994 5065])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("local_bh_enable_ip" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [5080 5099]))                  
                :type "int")
                nil [5066 5100])
            ("MAX_SOFTIRQ_RESTART" variable (:constant-flag t) nil [5442 5461])
            ("__do_softirq" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [5495 5500]))                  
                :type "void")
                nil [5477 6781])
            ("do_softirq" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [6841 6846]))                  
                :type "void")
                nil [6825 7043])
            ("irq_enter" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [7106 7111]))                  
                :type "void")
                nil [7091 7433])
            ("invoke_softirq" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [7753 7758]))                  
                :type "void")
                nil [7719 7957])
            ("irq_exit" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [8058 8063]))                  
                :type "void")
                nil [8044 8465])
            ("raise_softirq_irqoff" function
               (:typemodifiers ("inline")
                :arguments 
                  ( ("nr" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [8553 8569]))                  
                :type "void")
                nil [8520 8921])
            ("raise_softirq" function
               (:arguments 
                  ( ("nr" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [8942 8958]))                  
                :type "void")
                nil [8923 9063])
            ("open_softirq" function
               (:arguments 
                  ( ("nr" variable (:type "int") (reparse-symbol arg-sub-list) [9083 9090])
                    ("" variable (:type "void") (reparse-symbol arg-sub-list) [9091 9105]))                  
                :type "void")
                nil [9065 9169])
            ("tasklet_head" type
               (:members 
                  ( ("head" variable
                       (:pointer 1
                        :type ("tasklet_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [9213 9241])
                    ("tail" variable
                       (:pointer 2
                        :type ("tasklet_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [9243 9272]))                  
                :type "struct")
                nil [9190 9275])
            ("DEFINE_PER_CPU" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type ("tasklet_head" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol arg-sub-list) [9299 9319])
                    ("" variable (:type ("tasklet_vec" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [9320 9332]))                  
                :type "int")
                nil [9277 9333])
            ("DEFINE_PER_CPU" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type ("tasklet_head" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol arg-sub-list) [9356 9376])
                    ("" variable (:type ("tasklet_hi_vec" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [9377 9392]))                  
                :type "int")
                nil [9334 9393])
            ("__tasklet_schedule" function
               (:arguments 
                  ( ("t" variable
                       (:pointer 1
                        :type ("tasklet_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [9419 9444]))                  
                :type "void")
                nil [9395 9669])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("__tasklet_schedule" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [9685 9704]))                  
                :type "int")
                nil [9671 9705])
            ("__tasklet_hi_schedule" function
               (:arguments 
                  ( ("t" variable
                       (:pointer 1
                        :type ("tasklet_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [9734 9759]))                  
                :type "void")
                nil [9707 9986])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("__tasklet_hi_schedule" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [10002 10024]))                  
                :type "int")
                nil [9988 10025])
            ("__tasklet_hi_schedule_first" function
               (:arguments 
                  ( ("t" variable
                       (:pointer 1
                        :type ("tasklet_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [10060 10085]))                  
                :type "void")
                nil [10027 10246])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("__tasklet_hi_schedule_first" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [10262 10290]))                  
                :type "int")
                nil [10248 10291])
            ("tasklet_action" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("a" variable
                       (:pointer 1
                        :type ("softirq_action" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [10320 10345]))                  
                :type "void")
                nil [10293 11082])
            ("tasklet_hi_action" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("a" variable
                       (:pointer 1
                        :type ("softirq_action" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [11114 11139]))                  
                :type "void")
                nil [11084 11889])
            ("tasklet_init" function
               (:arguments 
                  ( ("t" variable
                       (:pointer 1
                        :type ("tasklet_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [11910 11935])
                    ("" variable (:type "void") (reparse-symbol arg-sub-list) [11940 11952])
                    ("data" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [11969 11988]))                  
                :type "void")
                nil [11892 12085])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("tasklet_init" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [12101 12114]))                  
                :type "int")
                nil [12087 12115])
            ("tasklet_kill" function
               (:arguments 
                  ( ("t" variable
                       (:pointer 1
                        :type ("tasklet_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [12135 12160]))                  
                :type "void")
                nil [12117 12445])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("tasklet_kill" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [12461 12474]))                  
                :type "int")
                nil [12447 12475])
            ("__hrtimer_tasklet_trampoline" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("timer" variable
                       (:pointer 1
                        :type ("hrtimer" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [12770 12792]))                  
                :type ("hrtimer_restart" type (:type "enum") nil nil))
                nil [12713 12952])
            ("__tasklet_hrtimer_trampoline" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("data" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [13086 13105]))                  
                :type "void")
                nil [13045 13304])
            ("tasklet_hrtimer_init" function
               (:arguments 
                  ( ("ttimer" variable
                       (:pointer 1
                        :type ("tasklet_hrtimer" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [13666 13697])
                    ("hrtimer_restart" type
                       (:members 
                          ( ("function" variable
                               (:constant-flag t
                                :type "int")
                                (reparse-symbol enumsubparts) [13726 13735]))                          
                        :type "enum")
                        (reparse-symbol arg-sub-list) [13703 13753])
                    ("" variable (:type ("hrtimer_restart" type
                         (:prototype t
                          :type "enum")
                          nil nil)) (reparse-symbol arg-sub-list) [13703 13753])
                    ("which_clock" variable (:type ("clockid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [13760 13782])
                    ("mode" variable (:type ("hrtimer_mode" type (:type "enum") nil nil)) (reparse-symbol arg-sub-list) [13783 13806]))                  
                :type "void")
                nil [13640 14039])
            ("EXPORT_SYMBOL_GPL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("tasklet_hrtimer_init" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [14058 14079]))                  
                :type "int")
                nil [14040 14080])
            ("DEFINE_PER_CPU" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("list_head" type (:type "struct") nil nil)) (reparse-symbol arg-sub-list) [14128 14159])
                    ("" variable (:type ("softirq_work_list" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [14160 14178]))                  
                :type "int")
                nil [14113 14179])
            ("EXPORT_PER_CPU_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("softirq_work_list" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [14202 14220]))                  
                :type "int")
                nil [14180 14221])
            ("__local_trigger" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("cp" variable
                       (:pointer 1
                        :type ("call_single_data" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [14251 14279])
                    ("softirq" variable (:type "int") (reparse-symbol arg-sub-list) [14280 14292]))                  
                :type "void")
                nil [14223 14531])
            ("__try_remote_softirq" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("cp" variable
                       (:pointer 1
                        :type ("call_single_data" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [15149 15177])
                    ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [15178 15186])
                    ("softirq" variable (:type "int") (reparse-symbol arg-sub-list) [15187 15199]))                  
                :type "int")
                nil [15117 15214])
            ("__send_remote_softirq" function
               (:arguments 
                  ( ("cp" variable
                       (:pointer 1
                        :type ("call_single_data" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [15645 15673])
                    ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [15674 15682])
                    ("this_cpu" variable (:type "int") (reparse-symbol arg-sub-list) [15683 15696])
                    ("softirq" variable (:type "int") (reparse-symbol arg-sub-list) [15697 15709]))                  
                :type "void")
                nil [15618 15809])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("__send_remote_softirq" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [15824 15846]))                  
                :type "int")
                nil [15810 15847])
            ("send_remote_softirq" function
               (:arguments 
                  ( ("cp" variable
                       (:pointer 1
                        :type ("call_single_data" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [16181 16209])
                    ("cpu" variable (:type "int") (reparse-symbol arg-sub-list) [16210 16218])
                    ("softirq" variable (:type "int") (reparse-symbol arg-sub-list) [16219 16231]))                  
                :type "void")
                nil [16156 16408])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("send_remote_softirq" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [16423 16443]))                  
                :type "int")
                nil [16409 16444])
            ("remote_softirq_cpu_notify" function
               (:arguments 
                  ( ("self" variable
                       (:pointer 1
                        :type ("notifier_block" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [16493 16521])
                    ("action" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [16534 16555])
                    ("hcpu" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [16556 16567]))                  
                :type ("__cpuinit" type (:type "class") nil nil))
                nil [16457 17149])
            ("remote_softirq_cpu_notifier" variable (:type ("__cpuinitdata" type (:type "class") nil nil)) nil [17180 17273])
            ("softirq_init" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [17300 17305]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [17280 17756])
            ("run_ksoftirqd" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("__bind_cpu" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [17783 17801]))                  
                :type "int")
                nil [17758 18839])
            ("cpu_callback" function
               (:arguments 
                  ( ("nfb" variable
                       (:pointer 1
                        :type ("notifier_block" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [20714 20741])
                    ("action" variable (:type "unsigned long") (reparse-symbol arg-sub-list) [20748 20769])
                    ("hcpu" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [20776 20787]))                  
                :type ("__cpuinit" type (:type "class") nil nil))
                nil [20691 21940])
            ("cpu_nfb" variable (:type ("__cpuinitdata" type (:type "class") nil nil)) nil [21971 22030])
            ("spawn_ksoftirqd" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [22066 22071]))                  
                :type "int")
                nil [22046 22293])
            ("early_initcall" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("spawn_ksoftirqd" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [22309 22325]))                  
                :type "int")
                nil [22294 22326])
            ("early_irq_init" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [22489 22494]))                  
                :type ("__weak" type (:type "class") nil nil))
                nil [22467 22509]))          
    :file "softirq.c"
    :pointmax 22680
    :fsize 22679
    :lastmodtime '(21468 9213 130212 413000)
    :unmatched-syntax '((symbol 22460 . 22466) (INT 22456 . 22459) (symbol 22039 . 22045) (STATIC 22032 . 22038) (symbol 21956 . 21970) (STRUCT 21949 . 21955) (STATIC 21942 . 21948) (INT 20687 . 20690) (STATIC 20680 . 20686) (VOID 17275 . 17279) (symbol 17165 . 17179) (STRUCT 17158 . 17164) (STATIC 17151 . 17157) (INT 16453 . 16456) (STATIC 16446 . 16452) (close-paren 14157 . 14158) (symbol 14146 . 14157) (open-paren 14145 . 14146) (semantic-list 13735 . 13753) (close-paren 13734 . 13735) (punctuation 13725 . 13726) (open-paren 13724 . 13725) (semantic-list 11952 . 11967) (semantic-list 11945 . 11952) (semantic-list 9105 . 9130) (semantic-list 9096 . 9105) (symbol 6814 . 6824) (symbol 5466 . 5476) (semantic-list 1519 . 1532) (symbol 1508 . 1519) (symbol 1493 . 1507) (STRUCT 1486 . 1492) (STATIC 1479 . 1485) (semantic-list 1413 . 1422) (symbol 1405 . 1413) (symbol 1391 . 1404) (semantic-list 13735 . 13753) (close-paren 13734 . 13735) (punctuation 13725 . 13726) (open-paren 13724 . 13725) (semantic-list 11952 . 11967) (semantic-list 11945 . 11952) (semantic-list 9105 . 9130) (semantic-list 9096 . 9105) (symbol 6814 . 6824) (symbol 5466 . 5476) (semantic-list 1519 . 1532) (symbol 1508 . 1519) (symbol 1493 . 1507) (STRUCT 1486 . 1492) (STATIC 1479 . 1485) (semantic-list 1413 . 1422) (symbol 1405 . 1413) (symbol 1391 . 1404) (symbol 22460 . 22466) (INT 22456 . 22459) (symbol 22039 . 22045) (STATIC 22032 . 22038) (symbol 21956 . 21970) (STRUCT 21949 . 21955) (STATIC 21942 . 21948) (INT 20687 . 20690) (STATIC 20680 . 20686) (VOID 17275 . 17279) (symbol 17165 . 17179) (STRUCT 17158 . 17164) (STATIC 17151 . 17157) (INT 16453 . 16456) (STATIC 16446 . 16452) (close-paren 14157 . 14158) (symbol 14146 . 14157) (open-paren 14145 . 14146) (semantic-list 13735 . 13753) (close-paren 13734 . 13735) (punctuation 13725 . 13726) (open-paren 13724 . 13725) (semantic-list 11952 . 11967) (semantic-list 11945 . 11952) (semantic-list 9105 . 9130) (semantic-list 9096 . 9105) (symbol 6814 . 6824) (symbol 5466 . 5476) (semantic-list 1519 . 1532) (symbol 1508 . 1519) (symbol 1493 . 1507) (STRUCT 1486 . 1492) (STATIC 1479 . 1485) (semantic-list 1413 . 1422) (symbol 1405 . 1413) (symbol 1391 . 1404))
    :lexical-table 
        '(("MAX_SOFTIRQ_RESTART" . ((number "10" 5462 . 5464)))
          ("CREATE_TRACE_POINTS")
          )

    )
   (semanticdb-table "params.c"
    :major-mode 'c-mode
    :tags 
        '( ("linux/moduleparam.h" include (:system-flag t) nil [818 848])
            ("linux/kernel.h" include (:system-flag t) nil [849 874])
            ("linux/string.h" include (:system-flag t) nil [875 900])
            ("linux/errno.h" include (:system-flag t) nil [901 925])
            ("linux/module.h" include (:system-flag t) nil [926 951])
            ("linux/device.h" include (:system-flag t) nil [952 977])
            ("linux/err.h" include (:system-flag t) nil [978 1000])
            ("linux/slab.h" include (:system-flag t) nil [1001 1024])
            ("linux/ctype.h" include (:system-flag t) nil [1025 1049])
            ("DEBUGP" variable (:constant-flag t) nil [1093 1099])
            ("DEFINE_MUTEX" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type ("param_lock" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [1209 1220]))                  
                :type "int")
                nil [1189 1221])
            ("kmalloced_param" type
               (:members 
                  ( ("list" variable (:type ("list_head" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol classsubparts) [1324 1346])
                    ("val" variable
                       (:dereference 1
                        :type "char")
                        (reparse-symbol classsubparts) [1348 1359]))                  
                :type "struct")
                nil [1298 1362])
            ("LIST_HEAD" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type ("kmalloced_params" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [1380 1397]))                  
                :type "int")
                nil [1363 1398])
            ("kmalloc_parameter" function
               (:pointer 1
                :typemodifiers ("static")
                :arguments 
                  ( ("size" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [1431 1449]))                  
                :type "void")
                nil [1400 1608])
            ("maybe_kfree_parameter" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("param" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [1700 1712]))                  
                :type "void")
                nil [1666 1874])
            ("dash2underscore" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("c" variable (:type "char") (reparse-symbol arg-sub-list) [1911 1918]))                  
                :type "char")
                nil [1876 1962])
            ("parameq" function
               (:typemodifiers ("static" "inline")
                :arguments 
                  ( ("input" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) [1990 2008])
                    ("paramname" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) [2009 2031]))                  
                :type "int")
                nil [1964 2161])
            ("parse_one" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("param" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [2184 2196])
                    ("val" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [2204 2214])
                    ("params" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [2222 2256])
                    ("num_params" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [2264 2284])
                    ("" variable (:type "int") (reparse-symbol arg-sub-list) [2292 2313]))                  
                :type "int")
                nil [2163 2971])
            ("next_arg" function
               (:pointer 1
                :typemodifiers ("static")
                :arguments 
                  ( ("args" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [3111 3122])
                    ("param" variable
                       (:pointer 2
                        :type "char")
                        (reparse-symbol arg-sub-list) [3123 3136])
                    ("val" variable
                       (:pointer 2
                        :type "char")
                        (reparse-symbol arg-sub-list) [3137 3148]))                  
                :type "char")
                nil [3089 3915])
            ("parse_args" function
               (:arguments 
                  ( ("name" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) [3982 3999])
                    ("args" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [4008 4019])
                    ("params" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [4028 4062])
                    ("num" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [4071 4084])
                    ("" variable (:type "int") (reparse-symbol arg-sub-list) [4093 4107]))                  
                :type "int")
                nil [3967 5021])
            ("STANDARD_PARAM_DEF" variable (:constant-flag t) nil [5055 5073])
            ("param_set_byte" function
               (:arguments 
                  ( ("val" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) nil)
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5810 5886])
            ("param_get_byte" function
               (:arguments 
                  ( ("buffer" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) nil)
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5810 5886])
            ("param_ops_byte" variable (:type ("kernel_param_ops" type
                 (:prototype t
                  :type "struct")
                  nil nil)) nil [5810 5886])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_set_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type ("byte" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5810 5886])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_get_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type ("byte" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5810 5886])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_ops_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type ("byte" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5810 5887])
            ("param_set_short" function
               (:arguments 
                  ( ("val" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) nil)
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5888 5948])
            ("param_get_short" function
               (:arguments 
                  ( ("buffer" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) nil)
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5888 5948])
            ("param_ops_short" variable (:type ("kernel_param_ops" type
                 (:prototype t
                  :type "struct")
                  nil nil)) nil [5888 5948])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_set_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type "short") (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5888 5948])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_get_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type "short") (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5888 5948])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_ops_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type "short") (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5888 5949])
            ("param_set_ushort" function
               (:arguments 
                  ( ("val" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) nil)
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5950 6030])
            ("param_get_ushort" function
               (:arguments 
                  ( ("buffer" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) nil)
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5950 6030])
            ("param_ops_ushort" variable (:type ("kernel_param_ops" type
                 (:prototype t
                  :type "struct")
                  nil nil)) nil [5950 6030])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_set_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type ("ushort" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5950 6030])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_get_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type ("ushort" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5950 6030])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_ops_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type ("ushort" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [5950 6031])
            ("param_set_int" function
               (:arguments 
                  ( ("val" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) nil)
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6032 6087])
            ("param_get_int" function
               (:arguments 
                  ( ("buffer" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) nil)
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6032 6087])
            ("param_ops_int" variable (:type ("kernel_param_ops" type
                 (:prototype t
                  :type "struct")
                  nil nil)) nil [6032 6087])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_set_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type "int") (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6032 6087])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_get_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type "int") (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6032 6087])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_ops_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type "int") (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6032 6088])
            ("param_set_uint" function
               (:arguments 
                  ( ("val" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) nil)
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6089 6164])
            ("param_get_uint" function
               (:arguments 
                  ( ("buffer" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) nil)
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6089 6164])
            ("param_ops_uint" variable (:type ("kernel_param_ops" type
                 (:prototype t
                  :type "struct")
                  nil nil)) nil [6089 6164])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_set_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type ("uint" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6089 6164])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_get_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type ("uint" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6089 6164])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_ops_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type ("uint" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6089 6165])
            ("param_set_long" function
               (:arguments 
                  ( ("val" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) nil)
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6166 6224])
            ("param_get_long" function
               (:arguments 
                  ( ("buffer" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) nil)
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6166 6224])
            ("param_ops_long" variable (:type ("kernel_param_ops" type
                 (:prototype t
                  :type "struct")
                  nil nil)) nil [6166 6224])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_set_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type "long") (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6166 6224])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_get_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type "long") (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6166 6224])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_ops_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type "long") (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6166 6225])
            ("param_set_ulong" function
               (:arguments 
                  ( ("val" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) nil)
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6226 6304])
            ("param_get_ulong" function
               (:arguments 
                  ( ("buffer" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) nil)
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6226 6304])
            ("param_ops_ulong" variable (:type ("kernel_param_ops" type
                 (:prototype t
                  :type "struct")
                  nil nil)) nil [6226 6304])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_set_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type ("ulong" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6226 6304])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_get_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type ("ulong" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6226 6304])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_ops_" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil)
                    ("" variable (:type ("ulong" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) nil))                  
                :type "int")
                nil [6226 6305])
            ("param_set_charp" function
               (:arguments 
                  ( ("val" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) [6327 6343])
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [6344 6374]))                  
                :type "int")
                nil [6307 6881])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_set_charp" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [6896 6912]))                  
                :type "int")
                nil [6882 6913])
            ("param_get_charp" function
               (:arguments 
                  ( ("buffer" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [6935 6948])
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [6949 6979]))                  
                :type "int")
                nil [6915 7035])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_get_charp" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [7050 7066]))                  
                :type "int")
                nil [7036 7067])
            ("param_free_charp" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("arg" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [7098 7108]))                  
                :type "void")
                nil [7069 7153])
            ("param_ops_charp" variable (:type ("kernel_param_ops" type
                 (:prototype t
                  :type "struct")
                  nil nil)) nil [7155 7278])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_ops_charp" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [7293 7309]))                  
                :type "int")
                nil [7279 7310])
            ("param_set_bool" function
               (:arguments 
                  ( ("val" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) [7397 7413])
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [7414 7444]))                  
                :type "int")
                nil [7378 7695])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_set_bool" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [7710 7725]))                  
                :type "int")
                nil [7696 7726])
            ("param_get_bool" function
               (:arguments 
                  ( ("buffer" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [7747 7760])
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [7761 7791]))                  
                :type "int")
                nil [7728 8005])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_get_bool" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [8020 8035]))                  
                :type "int")
                nil [8006 8036])
            ("param_ops_bool" variable (:type ("kernel_param_ops" type
                 (:prototype t
                  :type "struct")
                  nil nil)) nil [8038 8131])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_ops_bool" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [8146 8161]))                  
                :type "int")
                nil [8132 8162])
            ("param_set_invbool" function
               (:arguments 
                  ( ("val" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) [8215 8231])
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [8232 8262]))                  
                :type "int")
                nil [8193 8468])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_set_invbool" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [8483 8501]))                  
                :type "int")
                nil [8469 8502])
            ("param_get_invbool" function
               (:arguments 
                  ( ("buffer" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [8526 8539])
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [8540 8570]))                  
                :type "int")
                nil [8504 8637])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_get_invbool" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [8652 8670]))                  
                :type "int")
                nil [8638 8671])
            ("param_ops_invbool" variable (:type ("kernel_param_ops" type
                 (:prototype t
                  :type "struct")
                  nil nil)) nil [8673 8775])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_ops_invbool" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [8790 8808]))                  
                :type "int")
                nil [8776 8809])
            ("param_array" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("name" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) [8881 8898])
                    ("val" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) [8908 8924])
                    ("min" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [8934 8951])
                    ("max" variable (:type "unsigned int") (reparse-symbol arg-sub-list) [8952 8969])
                    ("elem" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [8979 8990])
                    ("elemsize" variable (:type "int") (reparse-symbol arg-sub-list) [8991 9004])
                    ("" variable (:type "int") (reparse-symbol arg-sub-list) [9014 9024])
                    ("flags" variable (:type ("u16" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [9080 9090])
                    ("num" variable
                       (:pointer 1
                        :type "unsigned int")
                        (reparse-symbol arg-sub-list) [9100 9118]))                  
                :type "int")
                nil [8858 9868])
            ("param_array_set" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("val" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) [9897 9913])
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [9914 9944]))                  
                :type "int")
                nil [9870 10152])
            ("param_array_get" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("buffer" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [10181 10194])
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [10195 10225]))                  
                :type "int")
                nil [10154 10627])
            ("param_array_free" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("arg" variable
                       (:pointer 1
                        :type "void")
                        (reparse-symbol arg-sub-list) [10658 10668]))                  
                :type "void")
                nil [10629 10858])
            ("param_array_ops" variable (:type ("kernel_param_ops" type
                 (:prototype t
                  :type "struct")
                  nil nil)) nil [10860 10983])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_array_ops" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [10998 11014]))                  
                :type "int")
                nil [10984 11015])
            ("param_set_copystring" function
               (:arguments 
                  ( ("val" variable
                       (:pointer 1
                        :constant-flag t
                        :type "char")
                        (reparse-symbol arg-sub-list) [11042 11058])
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [11059 11089]))                  
                :type "int")
                nil [11017 11327])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_set_copystring" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [11342 11363]))                  
                :type "int")
                nil [11328 11364])
            ("param_get_string" function
               (:arguments 
                  ( ("buffer" variable
                       (:pointer 1
                        :type "char")
                        (reparse-symbol arg-sub-list) [11387 11400])
                    ("kp" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [11401 11431]))                  
                :type "int")
                nil [11366 11530])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_get_string" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [11545 11562]))                  
                :type "int")
                nil [11531 11563])
            ("param_ops_string" variable (:type ("kernel_param_ops" type
                 (:prototype t
                  :type "struct")
                  nil nil)) nil [11565 11668])
            ("EXPORT_SYMBOL" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("param_ops_string" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [11683 11700]))                  
                :type "int")
                nil [11669 11701])
            ("to_module_attr" variable (:constant-flag t) nil [11762 11776])
            ("to_module_kobject" variable (:constant-flag t) nil [11835 11852])
            ("__stop___param" variable
               (:dereference 1
                :typemodifiers ("extern")
                :type ("kernel_param" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [11902 11965])
            ("__start___param" variable
               (:dereference 1
                :typemodifiers ("extern")
                :type ("kernel_param" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [11902 11965])
            ("param_attribute" type
               (:members 
                  ( ("mattr" variable (:type ("module_attribute" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol classsubparts) [11993 12023])
                    ("param" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("kernel_param" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [12025 12058]))                  
                :type "struct")
                nil [11967 12061])
            ("module_param_attrs" type
               (:members 
                  ( ("num" variable (:type "unsigned int") (reparse-symbol classsubparts) [12092 12109])
                    ("grp" variable (:type ("attribute_group" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol classsubparts) [12111 12138])
                    ("attrs" variable
                       (:dereference 1
                        :type ("param_attribute" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [12140 12172]))                  
                :type "struct")
                nil [12063 12175])
            ("__modinit" variable (:constant-flag t) nil [13222 13231]))          
    :file "params.c"
    :pointmax 21788
    :fsize 21787
    :lastmodtime '(21468 9214 636176 757000)
    :unmatched-syntax '((semantic-list 9024 . 9069) (semantic-list 9018 . 9024) (semantic-list 4107 . 4131) (semantic-list 4097 . 4107) (semantic-list 2313 . 2337) (semantic-list 2296 . 2313))
    :lexical-table 
        '(("STANDARD_PARAM_DEF" (spp-arg-list ("name" "type" "format" "tmptype" "strtolfn") 5073 . 5112) . 
              ((INT "int" 5122 . 5125) (spp-symbol-merge ((symbol "param_set_" 5126 . 5136) (symbol "name" 5138 . 5142)) 5126 . 5142) (semantic-list "(const char *val, const struct kernel_param *kp)" 5142 . 5190) (semantic-list "{								\\
		tmptype l;						\\
		int ret;						\\
									\\
		ret = strtolfn(val, 0, &l);				\\
		if (ret == -EINVAL || ((type)l != l))			\\
			return -EINVAL;					\\
		*((type *)kp->arg) = l;					\\
		return 0;						\\
	}" 5194 . 5411) (INT "int" 5422 . 5425) (spp-symbol-merge ((symbol "param_get_" 5426 . 5436) (symbol "name" 5438 . 5442)) 5426 . 5442) (semantic-list "(char *buffer, const struct kernel_param *kp)" 5442 . 5487) (semantic-list "{								\\
		return sprintf(buffer, format, *((type *)kp->arg));	\\
	}" 5491 . 5560) (STRUCT "struct" 5571 . 5577) (symbol "kernel_param_ops" 5578 . 5594) (spp-symbol-merge ((symbol "param_ops_" 5595 . 5605) (symbol "name" 5607 . 5611)) 5595 . 5611) (punctuation "=" 5612 . 5613) (semantic-list "{			\\
		.set = param_set_##name,				\\
		.get = param_get_##name,				\\
	}" 5614 . 5686) (punctuation ";" 5686 . 5687) (symbol "EXPORT_SYMBOL" 5698 . 5711) (semantic-list "(param_set_##name)" 5711 . 5729) (punctuation ";" 5729 . 5730) (symbol "EXPORT_SYMBOL" 5737 . 5750) (semantic-list "(param_get_##name)" 5750 . 5768) (punctuation ";" 5768 . 5769) (symbol "EXPORT_SYMBOL" 5776 . 5789) (semantic-list "(param_ops_##name)" 5789 . 5807)))
          ("to_module_attr" (spp-arg-list ("n") 11776 . 11779) . ((symbol "container_of" 11780 . 11792) (semantic-list "(n, struct module_attribute, attr)" 11792 . 11826)))
          ("__modinit" . ((symbol "__init" 13232 . 13238)))
          ("DEBUGP" (spp-arg-list ("fmt" "a...") 1099 . 1110))
          ("to_module_kobject" (spp-arg-list ("n") 11852 . 11855) . ((symbol "container_of" 11856 . 11868) (semantic-list "(n, struct module_kobject, kobj)" 11868 . 11900)))
          )

    )
   (semanticdb-table "taskstats.c"
    :major-mode 'c-mode
    :tags 
        '( ("linux/kernel.h" include (:system-flag t) nil [671 696])
            ("linux/taskstats_kern.h" include (:system-flag t) nil [697 730])
            ("linux/tsacct_kern.h" include (:system-flag t) nil [731 761])
            ("linux/delayacct.h" include (:system-flag t) nil [762 790])
            ("linux/cpumask.h" include (:system-flag t) nil [791 817])
            ("linux/percpu.h" include (:system-flag t) nil [818 843])
            ("linux/slab.h" include (:system-flag t) nil [844 867])
            ("linux/cgroupstats.h" include (:system-flag t) nil [868 898])
            ("linux/cgroup.h" include (:system-flag t) nil [899 924])
            ("linux/fs.h" include (:system-flag t) nil [925 946])
            ("linux/file.h" include (:system-flag t) nil [947 970])
            ("net/genetlink.h" include (:system-flag t) nil [971 997])
            ("asm/atomic.h" include (:system-flag t) nil [998 1021])
            ("TASKSTATS_CPUMASK_MAXLEN" variable (:constant-flag t) nil [1158 1182])
            ("DEFINE_PER_CPU" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type ("__u32" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [1222 1228])
                    ("" variable (:type ("taskstats_seqnum" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [1229 1246]))                  
                :type "int")
                nil [1200 1247])
            ("family_registered" variable
               (:typemodifiers ("static")
                :type "int")
                nil [1248 1277])
            ("taskstats_cache" variable
               (:pointer 1
                :type ("kmem_cache" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [1278 1313])
            ("family" variable
               (:typemodifiers ("static")
                :type ("genl_family" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [1315 1483])
            ("taskstats_cmd_get_policy" variable
               (:dereference 1
                :typemodifiers ("static")
                :constant-flag t
                :type ("nla_policy" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [1485 1804])
            ("cgroupstats_cmd_get_policy" variable
               (:dereference 1
                :typemodifiers ("static")
                :constant-flag t
                :type ("nla_policy" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [1806 1948])
            ("listener" type
               (:members 
                  ( ("list" variable (:type ("list_head" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol classsubparts) [1969 1991])
                    ("pid" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol classsubparts) [1993 2003])
                    ("valid" variable (:type "char") (reparse-symbol classsubparts) [2005 2016]))                  
                :type "struct")
                nil [1950 2019])
            ("listener_list" type
               (:members 
                  ( ("sem" variable (:type ("rw_semaphore" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol classsubparts) [2045 2069])
                    ("list" variable (:type ("list_head" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol classsubparts) [2071 2093]))                  
                :type "struct")
                nil [2021 2096])
            ("DEFINE_PER_CPU" function
               (:prototype-flag t
                :typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type ("listener_list" type
                         (:prototype t
                          :type "struct")
                          nil nil)) (reparse-symbol arg-sub-list) [2119 2140])
                    ("" variable (:type ("listener_array" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [2141 2156]))                  
                :type "int")
                nil [2097 2157])
            ("actions" type
               (:members 
                  ( ("REGISTER" variable
                       (:constant-flag t
                        :type "int")
                        (reparse-symbol enumsubparts) [2175 2184])
                    ("DEREGISTER" variable
                       (:constant-flag t
                        :type "int")
                        (reparse-symbol enumsubparts) [2186 2197])
                    ("CPU_DONT_CARE" variable
                       (:constant-flag t
                        :type "int")
                        (reparse-symbol enumsubparts) [2199 2214]))                  
                :type "enum")
                nil [2159 2215])
            ("prepare_reply" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("info" variable
                       (:pointer 1
                        :type ("genl_info" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [2242 2265])
                    ("cmd" variable (:type ("u8" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [2266 2273])
                    ("skbp" variable
                       (:pointer 2
                        :type ("sk_buff" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [2274 2296])
                    ("size" variable (:type ("size_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [2301 2313]))                  
                :type "int")
                nil [2217 2771])
            ("send_reply" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("skb" variable
                       (:pointer 1
                        :type ("sk_buff" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [2862 2882])
                    ("info" variable
                       (:pointer 1
                        :type ("genl_info" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [2883 2906]))                  
                :type "int")
                nil [2840 3132])
            ("send_cpu_listeners" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("skb" variable
                       (:pointer 1
                        :type ("sk_buff" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [3248 3268])
                    ("listeners" variable
                       (:pointer 1
                        :type ("listener_list" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [3274 3306]))                  
                :type "void")
                nil [3217 4265])
            ("fill_stats" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("tsk" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [4290 4314])
                    ("stats" variable
                       (:pointer 1
                        :type ("taskstats" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [4315 4339]))                  
                :type "void")
                nil [4267 4796])
            ("fill_stats_for_pid" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("pid" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [4828 4838])
                    ("stats" variable
                       (:pointer 1
                        :type ("taskstats" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [4839 4863]))                  
                :type "int")
                nil [4798 5084])
            ("fill_stats_for_tgid" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("tgid" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [5117 5128])
                    ("stats" variable
                       (:pointer 1
                        :type ("taskstats" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [5129 5153]))                  
                :type "int")
                nil [5086 6172])
            ("fill_tgid_exit" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("tsk" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [6201 6225]))                  
                :type "void")
                nil [6174 6642])
            ("add_del_listener" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("pid" variable (:type ("pid_t" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [6672 6682])
                    ("mask" variable
                       (:pointer 1
                        :constant-flag t
                        :type ("cpumask" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [6683 6710])
                    ("isadd" variable (:type "int") (reparse-symbol arg-sub-list) [6711 6721]))                  
                :type "int")
                nil [6644 7773])
            ("parse" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("na" variable
                       (:pointer 1
                        :type ("nlattr" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [7792 7810])
                    ("mask" variable
                       (:pointer 1
                        :type ("cpumask" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [7811 7832]))                  
                :type "int")
                nil [7775 8159])
            ("mk_reply" function
               (:pointer 1
                :typemodifiers ("static")
                :arguments 
                  ( ("skb" variable
                       (:pointer 1
                        :type ("sk_buff" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [8315 8335])
                    ("type" variable (:type "int") (reparse-symbol arg-sub-list) [8336 8345])
                    ("pid" variable (:type ("u32" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [8346 8354]))                  
                :type ("taskstats" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [8281 9951])
            ("cgroupstats_user_cmd" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("skb" variable
                       (:pointer 1
                        :type ("sk_buff" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [9985 10005])
                    ("info" variable
                       (:pointer 1
                        :type ("genl_info" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [10006 10029]))                  
                :type "int")
                nil [9953 10857])
            ("cmd_attr_register_cpumask" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("info" variable
                       (:pointer 1
                        :type ("genl_info" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [10896 10919]))                  
                :type "int")
                nil [10859 11207])
            ("cmd_attr_deregister_cpumask" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("info" variable
                       (:pointer 1
                        :type ("genl_info" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [11248 11271]))                  
                :type "int")
                nil [11209 11563])
            ("taskstats_packet_size" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [11601 11606]))                  
                :type ("size_t" type (:type "class") nil nil))
                nil [11565 11835])
            ("cmd_attr_pid" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("info" variable
                       (:pointer 1
                        :type ("genl_info" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [11861 11884]))                  
                :type "int")
                nil [11837 12385])
            ("cmd_attr_tgid" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("info" variable
                       (:pointer 1
                        :type ("genl_info" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [12412 12435]))                  
                :type "int")
                nil [12387 12943])
            ("taskstats_user_cmd" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("skb" variable
                       (:pointer 1
                        :type ("sk_buff" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [12975 12995])
                    ("info" variable
                       (:pointer 1
                        :type ("genl_info" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [12996 13019]))                  
                :type "int")
                nil [12945 13404])
            ("taskstats_tgid_alloc" function
               (:pointer 1
                :typemodifiers ("static")
                :arguments 
                  ( ("tsk" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [13452 13476]))                  
                :type ("taskstats" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [13406 13935])
            ("taskstats_exit" function
               (:arguments 
                  ( ("tsk" variable
                       (:pointer 1
                        :type ("task_struct" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [13989 14013])
                    ("group_dead" variable (:type "int") (reparse-symbol arg-sub-list) [14014 14029]))                  
                :type "void")
                nil [13969 15133])
            ("taskstats_ops" variable
               (:typemodifiers ("static")
                :type ("genl_ops" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [15135 15274])
            ("cgroupstats_ops" variable
               (:typemodifiers ("static")
                :type ("genl_ops" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [15276 15423])
            ("taskstats_init_early" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [15495 15500]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [15467 15710])
            ("taskstats_init" function
               (:arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [15745 15750]))                  
                :type ("__init" type (:type "class") nil nil))
                nil [15723 16209])
            ("late_initcall" function
               (:prototype-flag t
                :arguments 
                  ( ("" variable (:type ("taskstats_init" type (:type "class") nil nil)) (reparse-symbol arg-sub-list) [16362 16377]))                  
                :type "int")
                nil [16348 16378]))          
    :file "taskstats.c"
    :pointmax 16379
    :fsize 16378
    :lastmodtime '(21468 9213 819196 101000)
    :unmatched-syntax '((INT 15719 . 15722) (STATIC 15712 . 15718) (VOID 15462 . 15466))
    :lexical-table 
        '(("TASKSTATS_CPUMASK_MAXLEN" . ((semantic-list "(100+6*NR_CPUS)" 1183 . 1198)))
          )

    )
   (semanticdb-table "rcutiny_plugin.h"
    :major-mode 'c-mode
    :tags 
        '( ("linux/kthread.h" include (:system-flag t) nil [985 1011])
            ("linux/debugfs.h" include (:system-flag t) nil [1012 1038])
            ("linux/seq_file.h" include (:system-flag t) nil [1039 1066])
            ("RCU_TRACE" variable (:constant-flag t) nil [1165 1174])
            ("rcu_ctrlblk" type
               (:members 
                  ( ("rcucblist" variable
                       (:pointer 1
                        :type ("rcu_head" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [1311 1338])
                    ("donetail" variable
                       (:pointer 2
                        :type ("rcu_head" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [1379 1406])
                    ("curtail" variable
                       (:pointer 2
                        :type ("rcu_head" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol classsubparts) [1448 1474]))                  
                :type "struct")
                nil [1289 1563])
            ("rcu_sched_ctrlblk" variable
               (:typemodifiers ("static")
                :type ("rcu_ctrlblk" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [1610 1745])
            ("rcu_bh_ctrlblk" variable
               (:typemodifiers ("static")
                :type ("rcu_ctrlblk" type
                     (:prototype t
                      :type "struct")
                      nil nil))
                nil [1747 1873])
            ("rcu_boost" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [27786 27791]))                  
                :type "int")
                nil [27765 27806])
            ("rcu_preempt_check_callbacks" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [27938 27943]))                  
                :type "void")
                nil [27898 27947])
            ("rcu_preempt_remove_callbacks" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("rcp" variable
                       (:pointer 1
                        :type ("rcu_ctrlblk" type
                             (:prototype t
                              :type "struct")
                              nil nil))
                        (reparse-symbol arg-sub-list) [28081 28105]))                  
                :type "void")
                nil [28040 28109])
            ("rcu_preempt_process_callbacks" function
               (:typemodifiers ("static")
                :arguments 
                  ( ("" variable (:type "void") (reparse-symbol arg-sub-list) [28245 28250]))                  
                :type "void")
                nil [28203 28254])
            ("RCU_BOOST_PRIO" variable (:constant-flag t) nil [28774 28788]))          
    :file "rcutiny_plugin.h"
    :pointmax 30910
    :fsize 30909
    :lastmodtime '(21468 9214 948169 371000)
    :unmatched-syntax '((punctuation 1529 . 1530))
    :lexical-table 
        '(("RCU_TRACE" (spp-arg-list ("stmt") 1174 . 1180))
          ("RCU_BOOST_PRIO" . ((number "1" 28789 . 28790)))
          )

    )
   (semanticdb-table "rcutree.c"
    :major-mode 'c-mode
    :tags nil
    :file "rcutree.c"
    :pointmax 63318
    :fsize 63317
    :lastmodtime '(21468 9214 984168 518000)
    :unmatched-syntax 'nil
    )
   )
  :file "!home!chz!linux-3.0.8!kernel!semantic.cache"
  :semantic-tag-version "2.0"
  :semanticdb-version "2.2"
  )
