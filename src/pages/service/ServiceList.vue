<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { useServices, useNameSearch, useTools, useActive } from 'src/composables';
import {
  Page,
  PageHeader,
  PageBody,
  SearchInput,
  WaitingLoad,
  BtnBack,
  BtnAdd
} from 'src/components';

const router = useRouter();

const documents = ref([]);

const appName = 'service-list';

const { active } = useActive();

const { loading, clearService, getServices } = useServices();
const { searchQuery, matchingSearchQuery: services } = useNameSearch(documents);
const { notify, fmt } = useTools();

const handleBackTo = () => {
  if (active.value.formName !== appName.value) {
    router.push({ name: active.value.formName });
  } else {
    router.push({ name: 'main-menu' });
  }
};

const handleAddService = () => {
  clearService();
  router.push({ name: 'service-form' });
};

const handleViewService = (selected) => {
  clearService();
  router.push({ name: 'service-view', params: { id: selected.id } });
};

const handleGetServices = async () => {
  try {
    documents.value = await getServices('id, name, measure_unit, unit_price, details');
  } catch (error) {
    notify.error('Erro ao obter os serviços.', error);
  }
};

onMounted(async () => {
  await handleGetServices();
});
</script>

<template>
  <page>
    <page-header>
      <template #left>
        <btn-back @click="handleBackTo()" />
      </template>
      <template #title>Serviços</template>
      <template #right>
        <btn-add @click="handleAddService()" />
      </template>
    </page-header>

    <page-body>
      <search-input v-model="searchQuery" />

      <waiting-load :showing="loading.value" />

      <q-list v-if="!loading.value" separator>
        <q-item
          v-for="(service, index) in services"
          :key="index"
          clickable
          @click="handleViewService(service)"
        >
          <q-item-section>
            <q-item-label> {{ service.name }} </q-item-label>
            <q-item-label v-if="service.details" caption> {{ service.details }} </q-item-label>
            <q-item-label class="text-right">
              {{ fmt.currency(service.unit_price) }}/{{ service.measure_unit }}
            </q-item-label>
          </q-item-section>
        </q-item>
      </q-list>
    </page-body>
  </page>
</template>
