<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useActive } from 'src/composables';

const router = useRouter();
const tab = ref('main-menu');
const { active, clearActive } = useActive();

const tabMenu = [
  { title: 'Início', icon: 'sym_o_grid_view', path: 'main-menu' },
  { title: 'Clientes', icon: 'sym_o_supervisor_account', path: 'customer-list' },
  { title: 'Pedidos', icon: 'sym_o_list_alt', path: 'order-list' },
  { title: 'Financeiro', icon: 'sym_o_insert_chart', path: 'finance' },
  { title: 'Agenda', icon: 'sym_o_calendar_month', path: 'appointment-list' }
];

const open = (path) => {
  clearActive();
  active.value.formName = path;
  tab.value = path;

  router.push({ name: path });
};
</script>

<template>
  <q-tabs
    v-model="tab"
    active-color="primary"
    indicator-color="transparent"
    class="text-grey-7 q-mx-auto"
    style="font-size: 16px"
    outside-arrows
    mobile-arrows
    no-caps
  >
    <q-tab
      v-for="(navItem, index) in tabMenu"
      :key="index"
      :name="navItem.path"
      :label="navItem.title"
      :icon="navItem.icon"
      @click="open(navItem.path)"
    />
  </q-tabs>
</template>
