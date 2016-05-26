<?php
require_once( DIR_SYSTEM.'library/vendor/webtopay/libwebtopay/WebToPay.php' );


ini_set('display_errors', 0);

class ControllerPaymentPaysera extends Controller {
	private $error = array();

	public function index() {
		$this->language->load('payment/paysera');
        $this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('setting/setting');

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
		    if($this->validate()) {
		        $this->load->model('setting/setting');
                $this->model_setting_setting->editSetting('paysera', $this->request->post);
                $this->session->data['success'] = $this->language->get('text_success');
                $this->response->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		    }
		}

		$data['heading_title'] = $this->language->get('heading_title');

        $data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		$data['text_on'] = $this->language->get('text_on');
		$data['text_off'] = $this->language->get('text_off');

		$data['entry_project'] = $this->language->get('entry_project');
		$data['entry_sign'] = $this->language->get('entry_sign');
        $data['entry_lang'] = $this->language->get('entry_lang');
        $data['help_lang'] = $this->language->get('help_lang');
		$data['entry_test'] = $this->language->get('entry_test');
		$data['entry_new_order_status'] = $this->language->get('entry_new_order_status');
		$data['entry_order_status'] = $this->language->get('entry_order_status');
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_default_payments'] = $this->language->get('entry_payment_lang');
		$data['entry_display_payments'] = $this->language->get('entry_paymentlist');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$data['help_callback'] = $this->language->get('help_callback');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		$data['tab_general'] = $this->language->get('tab_general');

		if (!isset($this->error['warning'])) $this->error['warning'] = '';
		$data['error_warning'] = $this->error['warning'];
		if (!isset($this->error['project'])) $this->error['project'] = '';
		$data['error_project'] = $this->error['project'];
		if (!isset($this->error['sign'])) $this->error['sign'] = '';
		$data['error_sign'] = $this->error['sign'];
		if (!isset($this->error['lang'])) $this->error['lang'] = '';
		$data['error_lang'] = $this->error['lang'];

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_payment'),
			'href' => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('payment/paysera', 'token=' . $this->session->data['token'], 'SSL')
		);

//        $this->data['action'] = $this->url->link('payment/paysera', 'token=' . $this->session->data['token'], 'SSL');
//
//        $this->data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');

//		$data['action'] = HTTPS_SERVER . 'index.php?route=payment/paysera&token=' . $this->session->data['token'];

        $data['action'] = $this->url->link('payment/paysera', 'token=' . $this->session->data['token'], 'SSL');

		$data['cancel'] = HTTPS_SERVER . 'index.php?route=extension/payment&token=' . $this->session->data['token'];

		if (isset($this->request->post['paysera_project'])) {
			$data['paysera_project'] = $this->request->post['paysera_project'];
		} else {
			$data['paysera_project'] = $this->config->get('paysera_project');
		}

		if (isset($this->request->post['paysera_sign'])) {
			$data['paysera_sign'] = $this->request->post['paysera_sign'];
		} else {
			$data['paysera_sign'] = $this->config->get('paysera_sign');
		}

		if (isset($this->request->post['paysera_lang'])) {
			$data['paysera_lang'] = $this->request->post['paysera_lang'];
		} else {
			$data['paysera_lang'] = $this->config->get('paysera_lang');
		}

		$data['callback'] = HTTP_CATALOG . 'index.php?route=payment/paysera/callback';

		if (isset($this->request->post['paysera_test'])) {
			$data['paysera_test'] = $this->request->post['paysera_test'];
		} else {
			$data['paysera_test'] = $this->config->get('paysera_test');
		}

		if (isset($this->request->post['paysera_order_status_id'])) {
			$data['paysera_order_status_id'] = $this->request->post['paysera_order_status_id'];
		} else {
			$data['paysera_order_status_id'] = $this->config->get('paysera_order_status_id');
		}

		if (isset($this->request->post['paysera_new_order_status_id'])) {
			$data['paysera_new_order_status_id'] = $this->request->post['paysera_new_order_status_id'];
		} else {
			$data['paysera_new_order_status_id'] = $this->config->get('paysera_new_order_status_id');
		}

	    if (isset($this->request->post['paysera_display_payments_list'])) {
			$data['paysera_display_payments_list'] = $this->request->post['paysera_display_payments_list'];
		} else {
			$data['paysera_display_payments_list'] = $this->config->get('paysera_display_payments_list');
		}

		$this->load->model('localisation/order_status');

		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses(); //here

		$data['payment_countries'] = $this->getCountries();

		if (isset($this->request->post['paysera_geo_zone_id'])) {
			$data['paysera_geo_zone_id'] = $this->request->post['paysera_geo_zone_id'];
		} else {
			$data['paysera_geo_zone_id'] = $this->config->get('paysera_geo_zone_id');
		}

	    if (isset($this->request->post['default_payment_country'])) {
			$data['default_payment_country'] = $this->request->post['default_payment_country'];
		} else {
			$data['default_payment_country'] = $this->config->get('default_payment_country');
		}

		$this->load->model('localisation/geo_zone');

		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

		if (isset($this->request->post['paysera_status'])) {
			$data['paysera_status'] = $this->request->post['paysera_status'];
		} else {
			$data['paysera_status'] = $this->config->get('paysera_status');
		}

		if (isset($this->request->post['paysera_sort_order'])) {
			$data['paysera_sort_order'] = $this->request->post['paysera_sort_order'];
		} else {
			$data['paysera_sort_order'] = $this->config->get('paysera_sort_order');
		}

		$this->template = 'payment/paysera.tpl';
		/*$this->children = array(
			'common/header',
			'common/footer'
		);*/
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');


		$this->response->setOutput($this->load->view($this->template, $data));
		//$this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));

	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'payment/paysera')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['paysera_project']) {
			$this->error['project'] = $this->language->get('error_project');
		}

		if (!$this->request->post['paysera_sign']) {
			$this->error['sign'] = $this->language->get('error_sign');
		}

        if (!$this->request->post['paysera_lang']) {
            $this->error['lang'] = $this->language->get('error_lang');
        }


        return !$this->error;
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

