<template>
  <div>
    <h1>{{title}}</h1>
    <a-table :dataSource="contents" :columns="columns" :pagination="false" rowKey="id" />
  </div>
</template>

<script>
export default {
  data () {
    return {
      title: 'Private Content',
      contents: [],
      columns: [
        { title: 'Id', dataIndex: 'id', key: 'id'},
        { title: 'Name', dataIndex: 'name', key: 'name'}
      ]
    }
  },
  methods: {
    async updateContent() {
      this.contents = await this.$axios.$get('/private_contents');
    }
  },
  mounted () {
    this.updateContent();
  }
}
</script>

<style>
.components-page-header-demo-responsive tr:last-child td {
  padding-bottom: 16px;
}
</style>