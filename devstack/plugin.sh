DASHABOARD_FILES=(_1710_project_dns_panel_group.py _1721_dns_zones_panel.py _1722_dns_reversedns_panel.py)

function install_designatedashboard {
    setup_develop ${DESIGNATEDASHBOARD_DIR}

    for panel in ${DASHABOARD_FILES[@]}; do
        ln -fs $DESIGNATEDASHBOARD_DIR/designatedashboard/enabled/$panel \
			$HORIZON_DIR/openstack_dashboard/local/enabled/$panel
    done
}


function configure_designatedashboard {

    # Compile message catalogs
    if [ -d ${DESIGNATEDASHBOARD_DIR}/designatedashboard/locale ]; then
        (cd ${DESIGNATEDASHBOARD_DIR}/designatedashboard; DJANGO_SETTINGS_MODULE=openstack_dashboard.settings ../manage.py compilemessages)
    fi
}

if is_service_enabled horizon && is_service_enabled designate; then
    if [[ "$1" == "stack" && "$2" == "install" ]]; then
        # Perform installation of service source
        echo_summary "Installing designate-dashboard"
        install_designatedashboard
    elif [[ "$1" == "stack" && "$2" == "post-config" ]]; then
        echo_summary "Configuring designate-dashboard"
        configure_designatedashboard
    elif [[ "$1" == "stack" && "$2" == "extra" ]]; then
        :
    fi

    if [[ "$1" == "unstack" ]]; then
        :
    fi

    if [[ "$1" == "clean" ]]; then
        # Remove state and transient data
        # Remember clean.sh first calls unstack.sh
		for panel in ${DASHABOARD_FILES[@]}; do
			rm $HORIZON_DIR/openstack_dashboard/local/enabled/$panel
		done
    fi
fi
