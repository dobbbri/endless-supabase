<script setup>
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { useUsersSettings, useTools } from 'src/composables';
import { useUsersSettingsStore } from 'src/stores/settingsStore';
import { Page, PageHeader, WaitingLoad } from 'src/components';

const router = useRouter();
const store = useUsersSettingsStore();

const { getSettings, addSettings } = useUsersSettings();
const { notify } = useTools();

const loading = ref(true);

const handleSettings = async () => {
  try {
    loading.value = true;
    let settings = await getSettings();
    if (settings) {
      store.setSettings(settings[0]);
    } else {
      const { measureUnits, paymentMethods, paymentConditions, orderStatus, costCategory } =
        store.getDefaults();
      settings = await addSettings({
        measure_units: measureUnits,
        payment_methods: paymentMethods,
        payment_conditions: paymentConditions,
        order_status: orderStatus,
        cost_category: costCategory
      });
      store.setSettings(settings);
    }
    loading.value = false;
    router.push({ name: 'main-menu' });
  } catch (error) {
    loading.value = false;
    notify.error('Erro ao executar as rotinas iniciais.', error);
  }
};

onMounted(() => {
  handleSettings();
});
</script>

<template>
  <page>
    <page-header>
      <template #title>Endless</template>
    </page-header>

    <waiting-load :showing="loading.value" />
  </page>
</template>
