<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useUsersSettings, useTools, useDefaults } from 'src/composables';
import { Page, PageHeader, PageBody, BtnBack, BtnSave } from 'src/components';
import { useUsersSettingsStore } from 'src/stores/settingsStore';

const store = useUsersSettingsStore();
const router = useRouter();

const { loading, editSettings } = useUsersSettings();
const { notify } = useTools();
const { attr } = useDefaults();

const paymentMethods = ref([]);
paymentMethods.value = store.paymentMethods;

const handleSubmit = async () => {
  try {
    await editSettings({
      id: store.id,
      payment_methods: JSON.stringify(paymentMethods.value)
    });
    notify.success('Forma de pagamento gravado.');
    router.push({ name: 'settings-form' });
  } catch (error) {
    notify.error(`Erro ao alterar a forma de pagamento.`, error);
  }
};
</script>

<template>
  <page>
    <q-form @submit.prevent="handleSubmit">
      <page-header>
        <template #left>
          <btn-back :to="{ name: 'settings-form' }" />
        </template>
        <template #title>Alterar Formas</template>
        <template #right>
          <btn-save :loading="loading.value" type="submit" />
        </template>
      </page-header>

      <page-body>
        <q-banner v-bind="attr.banner"> Escolha a forma que o cliente pode pagar </q-banner>

        <q-list separator>
          <q-item v-for="(paymentMethod, index) in paymentMethods" :key="index" class="q-pa-none">
            <q-item-section>
              <q-item-label class="text-subtitle2">
                <q-checkbox
                  v-bind="attr.input.basic"
                  :id="index"
                  v-model="paymentMethod.active"
                  :label="paymentMethod.name"
                  class="checkbox-fix"
                />
              </q-item-label>
            </q-item-section>
          </q-item>
        </q-list>
      </page-body>
    </q-form>
  </page>
</template>
