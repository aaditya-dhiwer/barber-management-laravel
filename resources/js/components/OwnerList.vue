<template>
  <div class="container my-4">
    <h2 class="mb-4">Owners & Shop Details</h2>

    <div v-for="owner in owners" :key="owner.id" class="card p-3 mb-3 shadow-sm">
      <h4>{{ owner.name }} ({{ owner.email }})</h4>

      <div v-for="shop in owner.shops" :key="shop.id" class="border p-3 rounded mt-3 bg-light">
        <h5>Shop: {{ shop.name }}</h5>
        <p><strong>Address:</strong> {{ shop.address }}</p>
        <p><strong>Current Step:</strong> {{ shop.current_step }}</p>

        <!-- Shop Images -->
        <div class="d-flex flex-wrap mb-2" v-if="shop.images.length">
          <img v-for="img in shop.images" :src="'/storage/' + img.path" 
               :key="img.id" width="90" class="me-2 rounded shadow">
        </div>

        <!-- Services -->
        <h6>Services:</h6>
        <ul>
          <li v-for="srv in shop.services" :key="srv.id">
            {{ srv.service.name }} - ₹{{ srv.service.price }}
          </li>
        </ul>

        <!-- Workers/Members -->
        <h6>Workers:</h6>
        <ul>
          <li v-for="member in shop.members" :key="member.id">
            {{ member.user.name }} ({{ member.user.email }})
          </li>
        </ul>

        <!-- Approve / Decline Buttons -->
        <button class="btn btn-success btn-sm me-2"
                @click="updateShop(shop.id, 5)">Approve</button>
        <button class="btn btn-danger btn-sm"
                @click="updateShop(shop.id, 6)">Decline</button>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: "OwnerList",
  data() {
    return {
      owners: [],
    };
  },
  mounted() {
    this.fetchOwners();
  },
  methods: {
    fetchOwners() {
      axios.get('/api/owners')
        .then(res => {
          this.owners = res.data;
        })
        .catch(err => console.log(err));
    },
    updateShop(shopId, status) {
      axios.post(`/api/shop/update-step/${shopId}`, { status })
        .then(() => {
          this.fetchOwners(); // Refresh data
        })
        .catch(err => console.log(err));
    }
  }
}
</script>

<style scoped>
.card {
  border-radius: 10px;
}
</style>
