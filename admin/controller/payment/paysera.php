<?php
require_once( DIR_SYSTEM.'library/vendor/webtopay/libwebtopay/WebToPay.php' );

class ControllerPaymentPaysera extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('payment/paysera');
		$this->load->model('setting/setting');

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
		    if($this->validate()) {
		        $this->load->model('setting/setting');
                $this->model_setting_setting->editSetting('paysera', $this->request->post);
                $this->session->data['success'] = $this->language->get('text_success');
                $this->redirect(HTTPS_SERVER . 'index.php?route=extension/payment&token=' . $this->session->data['token']);
		    }
		}
        
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_all_zones'] = $this->language->get('text_all_zones');
		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_on'] = $this->language->get('text_on');
		$this->data['text_off'] = $this->language->get('text_off');

		$this->data['entry_project'] = $this->language->get('entry_project');
		$this->data['entry_sign'] = $this->language->get('entry_sign');
		$this->data['entry_lang'] = $this->language->get('entry_lang');
		$this->data['entry_test'] = $this->language->get('entry_test');
		$this->data['entry_order_status'] = $this->language->get('entry_order_status');
		$this->data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_default_payments'] = $this->language->get('entry_payment_lang');
		$this->data['entry_display_payments'] = $this->language->get('entry_paymentlist');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['help_callback'] = $this->language->get('help_callback');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		$this->data['tab_general'] = $this->language->get('tab_general');

		if (!isset($this->error['warning'])) $this->error['warning'] = '';
		$this->data['error_warning'] = $this->error['warning'];
		if (!isset($this->error['project'])) $this->error['project'] = '';
		$this->data['error_project'] = $this->error['project'];
		if (!isset($this->error['sign'])) $this->error['sign'] = '';
		$this->data['error_sign'] = $this->error['sign'];
		if (!isset($this->error['lang'])) $this->error['lang'] = '';
		$this->data['error_lang'] = $this->error['lang'];

  		$this->document->breadcrumbs = array();

   		$this->document->breadcrumbs[] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=common/home',
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		);

   		$this->document->breadcrumbs[] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=extension/payment',
       		'text'      => $this->language->get('text_payment'),
      		'separator' => ' :: '
   		);

   		$this->document->breadcrumbs[] = array(
       		'href'      => HTTPS_SERVER . 'index.php?route=payment/paysera',
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		);

		$this->data['action'] = HTTPS_SERVER . 'index.php?route=payment/paysera&token=' . $this->session->data['token'];

		$this->data['cancel'] = HTTPS_SERVER . 'index.php?route=extension/payment&token=' . $this->session->data['token'];

		if (isset($this->request->post['paysera_project'])) {
			$this->data['paysera_project'] = $this->request->post['paysera_project'];
		} else {
			$this->data['paysera_project'] = $this->config->get('paysera_project');
		}

		if (isset($this->request->post['paysera_sign'])) {
			$this->data['paysera_sign'] = $this->request->post['paysera_sign'];
		} else {
			$this->data['paysera_sign'] = $this->config->get('paysera_sign');
		}

		if (isset($this->request->post['paysera_lang'])) {
			$this->data['paysera_lang'] = $this->request->post['paysera_lang'];
		} else {
			$this->data['paysera_lang'] = $this->config->get('paysera_lang');
		}

		$this->data['callback'] = HTTP_CATALOG . 'index.php?route=payment/paysera/callback';

		if (isset($this->request->post['paysera_test'])) {
			$this->data['paysera_test'] = $this->request->post['paysera_test'];
		} else {
			$this->data['paysera_test'] = $this->config->get('paysera_test');
		}

		if (isset($this->request->post['paysera_order_status_id'])) {
			$this->data['paysera_order_status_id'] = $this->request->post['paysera_order_status_id'];
		} else {
			$this->data['paysera_order_status_id'] = $this->config->get('paysera_order_status_id');
		}
		
	    if (isset($this->request->post['display_payments_list'])) {
			$this->data['display_payments_list'] = $this->request->post['display_payments_list'];
		} else {
			$this->data['display_payments_list'] = $this->config->get('display_payments_list');
		}

		$this->load->model('localisation/order_status');

		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses(); //here
        
		$this->data['payment_countries'] = $this->getCountries();

		if (isset($this->request->post['paysera_geo_zone_id'])) {
			$this->data['paysera_geo_zone_id'] = $this->request->post['paysera_geo_zone_id'];
		} else {
			$this->data['paysera_geo_zone_id'] = $this->config->get('paysera_geo_zone_id');
		}

	    if (isset($this->request->post['default_payment_country'])) {
			$this->data['default_payment_country'] = $this->request->post['default_payment_country'];
		} else {
			$this->data['default_payment_country'] = $this->config->get('default_payment_country');
		}

		$this->load->model('localisation/geo_zone');

		$this->data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

		if (isset($this->request->post['paysera_status'])) {
			$this->data['paysera_status'] = $this->request->post['paysera_status'];
		} else {
			$this->data['payasera_status'] = $this->config->get('paysera_status');
		}

		if (isset($this->request->post['paysera_sort_order'])) {
			$this->data['paysera_sort_order'] = $this->request->post['paysera_sort_order'];
		} else {
			$this->data['paysera_sort_order'] = $this->config->get('paysera_sort_order');
		}
		
		$this->template = 'payment/paysera.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));

	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'payment/paysera')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!@$this->request->post['paysera_project']) {
			$this->error['project'] = $this->language->get('error_project');
		}

		if (!@$this->request->post['paysera_sign']) {
			$this->error['sign'] = $this->language->get('error_sign');
		}

		if (!@$this->request->post['paysera_lang']) {
			$this->error['lang'] = $this->language->get('error_lang');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function getCountries() {
        $language = $this->language->get('code');
        $projectId = $this->config->get('paysera_project');

		if(!$projectId || !$language) {
            return null;
        }
      
        $methods = WebToPay::getPaymentMethodList($projectId)
        ->setDefaultLanguage($language);
        
        return $methods->getCountries();
	}
}

