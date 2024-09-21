lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 10.436316316316315 --fixed-mass2 44.13797797797798 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010883258.9747922 \
--gps-end-time 1010890458.9747922 \
--d-distr volume \
--min-distance 1121.0808773611839e3 --max-distance 1121.1008773611838e3 \
--l-distr fixed --longitude -11.185150146484375 --latitude 14.092296600341797 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
