proc main {} {
    clear -all

    check_sec -analyze -spec -sv -f_relative_to_file_location ref.f
    check_sec -elaborate -spec -top ref_###TOPMODULE###

    set my_clock [clock -analyze]

    if {$my_clock eq ""} {
        clock -none
    } else {
        clock -infer
    }

    set my_reset [reset -analyze -synchronous -list signal ]
    set filtered_reset {}

    # 遍历每个信号
    foreach signal $my_reset {
        # 捕获潜在的错误
        if {[catch {
            reset -expression $signal
            reset -clear
            lappend filtered_reset $signal

        } errMsg]} {
            puts "Error adding $signal to reset-list: $errMsg"
        } else {
            puts "$signal added to reset-list successfully."
        }
    }



    if {$filtered_reset eq ""} {
        reset -none
    } else {
        reset -expression ${filtered_reset}
    }
    reset -non_resettable_regs 0

    check_sec -analyze -imp -sv -f_relative_to_file_location top.f
    check_sec -elaborate -imp -top ###TOPMODULE###

    check_sec -setup
    # check_sec -auto_map_reset_x_values on


    

    # reset -none
    set_proofgrid_mode local
    set_proofgrid_per_engine_max_local_jobs 16
    set_proofgrid_max_local_jobs 16

    set_sec_autoprove_strategy basic
    # set_sec_autoprove_expose_internal_cex true
    # set_sec_autoprove_strategy state_matching
    set_sec_prove_cex_threshold 1
    set result [check_sec -prove]
    puts "JPW: ${result}"
    exit
}

if {[catch {
    main
} err]} {
    puts "Error occurred: $err"
    exit
}

